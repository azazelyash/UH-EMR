import 'package:aasa_emr/features/dashboard/data/models/patients.dart';
import 'package:aasa_emr/features/dashboard/presentations/providers/appointment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/widgets/custom_appbar_with_back_button.dart';
import 'widgets/patient_info_widget.dart';
import 'widgets/patient_appointment_tile.dart';

class PatientInfoScreen extends StatelessWidget {
  const PatientInfoScreen({
    super.key,
    required this.patient,
  });

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scrollbar(
          thickness: 6,
          interactive: true,
          trackVisibility: true,
          radius: const Radius.circular(10),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: 372,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
                    child: Column(
                      children: [
                        const CustomAppBarWithBackButton(),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Text(
                              "Patient Info",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        PatientInfoWidget(
                          patient: patient,
                        ),
                      ],
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(80.h),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "All Appointments",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.h),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Doctor",
                                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ConstantColors.kHeadlingColor),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Date",
                                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ConstantColors.kHeadlingColor),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    "Visit",
                                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ConstantColors.kHeadlingColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h),
                sliver: Consumer<AppointmentProvider>(
                  builder: (context, appointmentProvider, child) {
                    return SliverList.builder(
                      itemCount: appointmentProvider.patientAppointments?.length,
                      itemBuilder: (context, index) {
                        return (appointmentProvider.patientAppointments!.isNotEmpty)
                            ? PatientAppointmentTile(
                                index: 0,
                                appointment: appointmentProvider.patientAppointments![index],
                              )
                            : const Text("No Appointments Found");
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
