import 'package:aasa_emr/common/helper/utils.dart';

import 'package:aasa_emr/features/dashboard/presentations/screens/doctor_dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widgets/custom_appbar_with_back_button.dart';
import '../../../../common/widgets/expanded_elevated_button.dart';
import '../../../../utils/constants/colors.dart';
import 'widgets/rx_success_alert_dialog.dart';
import 'widgets/success_message_widget.dart';

class RxSuccessScreen extends StatelessWidget {
  const RxSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const CustomAppBarWithBackButton(home: true),
              SizedBox(height: 16.h),
              Expanded(
                child: Column(
                  children: [
                    const Spacer(),
                    const SuccessMessageWidget(phone: "+91 98100 23233"),
                    const Spacer(),
                    // SizedBox(height: 16.h),
                    // const MedsValueDescriptionWidget(),
                    // SizedBox(height: 16.h),
                    // const TestsValueDescriptionWidget(),
                    // SizedBox(height: 16.h),
                    TextFormField(
                      minLines: 3,
                      maxLines: null,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        hintText: "Add note for receptionist",
                      ),
                    ),
                    CheckboxListTile(
                      value: true,
                      onChanged: (val) {},
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Give Rx Copies",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    ExpandedElevatedButton(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return const RxSuccessAlertDialogWidget(
                              title:
                                  "Are you sure you want to send the order request to receptionist and end consultation.",
                            );
                          },
                        );
                      },
                      buttonStyle: ElevatedButton.styleFrom(
                        backgroundColor: ConstantColors.kSecondaryColor,
                      ),
                      title: "Send to Receptionist for order",
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 16.h),
              // Flex(
              //   direction: Axis.horizontal,
              //   children: <Widget>[
              //     const Expanded(child: Divider()),
              //     Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 12.w),
              //       child: const Text("Or"),
              //     ),
              //     const Expanded(child: Divider()),
              //   ],
              // ),
              // SizedBox(height: 16.h),
              // OrderNowWidget(
              //   orderNowButton: () {
              //     showDialog(
              //       context: context,
              //       builder: (context) {
              //         return const RxSuccessAlertDialogWidget(
              //           title: "Are you sure you want to place the order.",
              //         );
              //       },
              //     );
              //   },
              // ),
              // SizedBox(height: 16.h),
              // const SendRxInOtherLanguage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(10),
        child: ExpandedElevatedButton(
          onTap: () {
            try {
              Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(
                  builder: (context) => const DoctorDashboardScreen(),
                ),
                (route) => false,
              );
            } catch (e) {
              if (context.mounted) {
                Utils.showSnackBar(
                  context,
                  content: e.toString(),
                );
              }
            }
          },
          title: "End Consultation",
          buttonStyle: ElevatedButton.styleFrom(
            backgroundColor: ConstantColors.kErrorColor,
          ),
        ),
      ),
    );
  }
}
