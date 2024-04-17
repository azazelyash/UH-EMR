import 'dart:io';
import 'package:aasa_emr/features/dashboard/data/models/appointment.dart';
import 'package:aasa_emr/features/dashboard/presentations/providers/appointment_provider.dart';
import 'package:aasa_emr/features/dashboard/presentations/providers/dashboard_provider.dart';
import 'package:aasa_emr/features/user/data/models/clinic.dart';
import 'package:aasa_emr/features/user/presentation/providers/user_provider.dart';
import 'package:aasa_emr/service/analytics.dart';

import '../../../../common/widgets/universal_loading_widget.dart';
import 'rx_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'widgets/rx_invoice_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:aasa_emr/common/helper/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aasa_emr/features/dashboard/data/models/rx_model.dart';
import 'package:aasa_emr/features/rx_screen/domain/usecases/send_rx_to_patient_usecase.dart';

import '../providers/rx_provider.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../common/widgets/custom_appbar_with_back_button.dart';

class PreviewRxScreen extends StatefulWidget {
  const PreviewRxScreen({
    super.key,
    this.rxModel,
    this.appointment,
    this.isButtonDisabled,
  });

  final RxModel? rxModel;
  final Appointment? appointment;
  final bool? isButtonDisabled;

  @override
  State<PreviewRxScreen> createState() => _PreviewRxScreenState();
}

class _PreviewRxScreenState extends State<PreviewRxScreen> {
  @override
  Widget build(BuildContext context) {
    Clinic? selectedClinic;

    if (widget.appointment != null) {
      selectedClinic = context.read<UserProvider>().selectedClinics.firstWhere(
            (element) => element.id == widget.appointment?.clinic,
          );
    }
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
                    child: CustomAppBarWithBackButton(),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Preview Rx",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    color: ConstantColors.kRxPreviewColor,
                    child: DottedBorder(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      dashPattern: const [6, 3],
                      child: RxInvoiceWidget(
                        rxData: widget.rxModel,
                        logoUrl: selectedClinic?.logo,
                        appointment: widget.appointment,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: (widget.isButtonDisabled ?? false)
              ? const SizedBox()
              : Consumer2<RxProvider, UserProvider>(
                  builder: (context, rxProvider, userProvider, child) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        child: const Text("Send to Patient"),
                        onPressed: () async {
                          Analytics.logSendRxToPatient();
                          try {
                            final hiddenVitals = userProvider.user.settings?.rxFormat?.patientVitals;
                            if (widget.rxModel == null || widget.appointment == null) return;
                            final File? file = await rxProvider.generate(
                              data: widget.rxModel!,
                              appointment: widget.appointment!,
                              logoUrl: selectedClinic!.logo,
                              user: context.read<UserProvider>().user,
                              signatureUrl: context.read<UserProvider>().user.profile!.docSign,
                              showAge: hiddenVitals?.age ?? false,
                              showHeight: hiddenVitals?.height ?? false,
                              showWeight: hiddenVitals?.weight ?? false,
                              showPulseRate: hiddenVitals?.pulseRate ?? false,
                              showBodyTemperature: hiddenVitals?.bloodPressure ?? false,
                              showBloodPressure: hiddenVitals?.bodyTemperature ?? false,
                              showRespirationRate: hiddenVitals?.respirationRate ?? false,
                            );

                            if (file == null && context.mounted) {
                              Utils.showSnackBar(context, content: "An error occured");
                              return;
                            }

                            PlatformFile platformFile = PlatformFile(
                              path: file!.path,
                              name: 'Text',
                              size: await file.length(),
                            );

                            SendToPatientParams params = SendToPatientParams(
                              rxFile: platformFile,
                              name: widget.rxModel!.patientBasicDetail!.name!,
                              email: widget.rxModel!.patientBasicDetail!.email!,
                              phoneNumber: widget.appointment!.userPatient!.phone!.phoneNumber!,
                              countryCode: widget.appointment!.userPatient!.phone!.countryCode!,
                              doctorName: context.read<UserProvider>().user.profile!.name!,
                            );

                            await rxProvider.createRx(params: widget.rxModel!);

                            await rxProvider.sendRxToPatient(params: params);

                            if (!mounted) return;
                            final appointmentProvider = context.read<AppointmentProvider>();

                            int oldVisit = int.parse(widget.appointment!.visit!);

                            Appointment updatedAppointment = widget.appointment!.copyWith(
                              status: widget.appointment!.status?.copyWith(
                                appointmentStatus: AppointmentStatusValues.done,
                              ),
                              visit: (oldVisit + 1).toString(),
                            );

                            await appointmentProvider.updateAppointment(updatedAppointment);

                            if (rxProvider.nextDate != null) {
                              await appointmentProvider.createAppointment(
                                widget.appointment!.copyWith(
                                  dateTime: rxProvider.nextDate!,
                                ),
                              );
                            }

                            appointmentProvider.upcomingAppointmentController.refresh();
                            appointmentProvider.previousAppointmentController.refresh();

                            if (!mounted) return;
                            Utils.showSnackBar(
                              context,
                              content: "Rx Sent to ${widget.rxModel!.patientBasicDetail?.email}.",
                            );

                            context.read<DashboardProvider>().creatRxState = false;
                            context.read<DashboardProvider>().createNewPatient = false;
                            context.read<DashboardProvider>().startConsulationNow = false;
                            context.read<DashboardProvider>().fillDetailsState = false;

                            Navigator.of(context).pushAndRemoveUntil(
                              CupertinoPageRoute(
                                builder: (context) => const RxSuccessScreen(),
                              ),
                              (route) => false,
                            );
                          } catch (e) {
                            if (!mounted) return;
                            Utils.showSnackBar(
                              context,
                              content: e.toString(),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
        ),
        (context.watch<RxProvider>().isLoading || context.watch<AppointmentProvider>().isLoading) ? const UniversalLoadingWidget() : const SizedBox(),
      ],
    );
  }
}
