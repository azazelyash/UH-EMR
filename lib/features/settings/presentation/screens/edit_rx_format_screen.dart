import 'dart:developer';

import 'package:aasa_emr/common/helper/utils.dart';
import 'package:aasa_emr/features/rx_screen/presentation/screens/preview_rx_screen.dart';
import 'package:aasa_emr/service/analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../common/widgets/custom_appbar_with_back_button.dart';
import '../../../../common/widgets/custom_dropdown_widget.dart';
import '../../../../common/widgets/universal_loading_widget.dart';
import '../../../../utils/constants/colors.dart';
import '../../../user/presentation/providers/user_provider.dart';
import '../providers/header_info_provider.dart';
import '../providers/patient_vitals_provider.dart';
import 'widgets/patient_vitals_column.dart';
import 'widgets/rx_header_info_column.dart';

class EditRxFormatScreen extends StatefulWidget {
  static String routeName = "/editRxFormat";
  const EditRxFormatScreen({super.key});
  @override
  State<EditRxFormatScreen> createState() => _EditRxFormatScreenState();
}

class _EditRxFormatScreenState extends State<EditRxFormatScreen> {
  final TextEditingController messageController = TextEditingController();
  String signatureColor = "White";

  @override
  void initState() {
    final userProvider = context.read<UserProvider>();
    final user = userProvider.user;
    if (user.settings?.rxFormat?.footerInfo?.signatureColor != null) {
      signatureColor = user.settings!.rxFormat!.footerInfo!.signatureColor!;
    }
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const CustomAppBarWithBackButton(),
                  SizedBox(height: 16.h),
                  Text("Edit Rx Format", style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: 12.h),
                  const PatientVitalsColumn(),
                  SizedBox(height: 12.h),
                  const RxHeaderInfoColumn(),
                  SizedBox(height: 12.h),
                  // const RxFooterInfoWidget(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(width: 1, color: Colors.grey.shade400),
                    ),
                    child: Consumer<UserProvider>(
                      builder: (context, userProvider, child) {
                        final footerMessage = userProvider.user.settings?.rxFormat?.footerInfo?.message;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Rx Footer Info",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              children: <Widget>[
                                const Text("Current Message: "),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    footerMessage ?? "-",
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            TextFormField(
                              controller: messageController,
                              decoration: const InputDecoration(hintText: "New Message"),
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              children: <Widget>[
                                const Text("Signature Color:"),
                                SizedBox(width: 8.w),
                                SizedBox(
                                  width: 120,
                                  height: 32,
                                  child: CustomDropdownWidget(
                                    items: const ["Black", "White"],
                                    onChanged: (value) {
                                      signatureColor = value!;
                                      setState(() {});
                                    },
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade400,
                                    ),
                                    fillColor: ConstantColors.kWhiteColor,
                                    iconColor: Colors.black54,
                                    textColor: Colors.black54,
                                    value: signatureColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            color: ConstantColors.kWhiteColor,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () async {
                      Analytics.editRxFormat();
                      final patientVitalsProvider = context.read<PatientVitalsProvider>();
                      final selectedVitals = patientVitalsProvider.selectedVitals;
                      final headerInfoProvider = context.read<HeaderInfoProvider>();
                      final selectedHeaderInfo = headerInfoProvider.selectedHeaderInfo;
                      final userProvider = context.read<UserProvider>();
                      final user = userProvider.user;
                      log(signatureColor);
                      final updatedUser = user.copyWith(
                        settings: user.settings?.copyWith(
                          rxFormat: user.settings?.rxFormat?.copyWith(
                            patientVitals: user.settings?.rxFormat?.patientVitals?.copyWith(
                              age: selectedVitals.contains('Age'),
                              weight: selectedVitals.contains('Weight'),
                              height: selectedVitals.contains('Height'),
                              bodyTemperature: selectedVitals.contains('Body Temperature'),
                              bloodPressure: selectedVitals.contains('Blood Pressure'),
                              respirationRate: selectedVitals.contains('Respiration Rate'),
                              pulseRate: selectedVitals.contains('Pulse Rate'),
                            ),
                            rxHeaderInfo: user.settings?.rxFormat?.rxHeaderInfo?.copyWith(
                              logo: selectedHeaderInfo.contains('Logo'),
                              clinicAddress: selectedHeaderInfo.contains('Clinic Address'),
                              contactNo: selectedHeaderInfo.contains('Contact No.'),
                              emailId: selectedHeaderInfo.contains('Email Id'),
                            ),
                            footerInfo: user.settings?.rxFormat?.footerInfo?.copyWith(
                              message: messageController.text.isEmpty ? user.settings?.rxFormat?.footerInfo?.message : messageController.text.trim(),
                              signatureColor: signatureColor,
                            ),
                          ),
                        ),
                      );
                      try {
                        await userProvider.updateUser(updatedUser);
                        messageController.clear();
                        if (context.mounted) {
                          FocusScope.of(context).unfocus();
                        }
                        userProvider.getUser();

                        if (context.mounted) {
                          Utils.showSnackBar(context, content: "Updated");
                        }
                      } catch (e) {
                        if (context.mounted) {
                          Utils.showSnackBar(context, content: e.toString());
                        }
                      }
                    },
                    child: const Text("Save Changes"),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Preview Functionality
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => const PreviewRxScreen(
                            isButtonDisabled: true,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ConstantColors.kSecondaryColor,
                    ),
                    child: const Text("Preview Rx"),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (context.watch<UserProvider>().isLoading) const UniversalLoadingWidget()
      ],
    );
  }
}
