import 'package:aasa_emr/features/user/presentation/providers/user_provider.dart';
import 'package:aasa_emr/service/analytics.dart';

import '../../../dashboard/presentations/screens/choose_clinic_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../gen/assets.gen.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/strings.dart';
import '../../../../common/widgets/back_chevron_button.dart';
import '../../../../common/widgets/expanded_outline_button.dart';
import '../../../../common/widgets/universal_loading_widget.dart';
import '../../../../common/widgets/expanded_elevated_button.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../providers/auth_provider.dart';

class OtpInputScreen extends StatefulWidget {
  const OtpInputScreen({super.key, required this.email});
  final String email;

  @override
  State<OtpInputScreen> createState() => _OtpInputScreenState();
}

class _OtpInputScreenState extends State<OtpInputScreen> {
  OtpFieldControllerV2 otpController = OtpFieldControllerV2();

  String? otp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Assets.images.logo.image(width: 64),
                        BackChevronButton(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Consumer<AuthProvider>(
                          builder: (context, authProvider, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 56.h),
                                Text(Strings.otpScreenTitle, style: Theme.of(context).textTheme.titleLarge),
                                SizedBox(height: 8.h),
                                RichText(
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(text: Strings.otpScreenSubtitleEmail, style: Theme.of(context).textTheme.bodyMedium),
                                      TextSpan(text: widget.email, style: Theme.of(context).textTheme.titleSmall),
                                      TextSpan(text: Strings.otpExpireMessage, style: Theme.of(context).textTheme.bodyMedium),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 32.h),
                                OTPTextFieldV2(
                                  length: 6,
                                  width: double.infinity,
                                  controller: otpController,
                                  textFieldAlignment: MainAxisAlignment.spaceAround,
                                  fieldStyle: FieldStyle.box,
                                  outlineBorderRadius: 6,
                                  fieldWidth: 40,
                                  onCompleted: (value) {
                                    otp = value;
                                  },
                                  hasError: authProvider.otpHasError,
                                ),
                                SizedBox(height: 32.h),
                                ExpandedElevatedButton(
                                  title: "Continue",
                                  onTap: () async {
                                    if (otp == null || otp!.length < 6) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          margin: const EdgeInsets.all(6),
                                          backgroundColor: ConstantColors.kErrorBackgroundColor,
                                          shape: const RoundedRectangleBorder(
                                            side: BorderSide(color: ConstantColors.kErrorColor),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(6),
                                            ),
                                          ),
                                          content: Text(
                                            "Invalid OTP Length",
                                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                  color: ConstantColors.kErrorColor,
                                                ),
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    Analytics.logLogin();
                                    authProvider.otpHasError = false;
                                    FocusManager.instance.primaryFocus!.unfocus();
                                    try {
                                      final userProvider = context.read<UserProvider>();
                                      await authProvider.signIn(SignInUseCaseParams(otp: otp!, email: widget.email));

                                      if (context.mounted) {
                                        await userProvider.getUser();
                                        await userProvider.getClinics();
                                        await userProvider.getDropdownValues();
                                      }
                                      if (context.mounted) {
                                        Navigator.of(context).pushAndRemoveUntil(
                                          CupertinoPageRoute(
                                            builder: (context) => const ChooseClinicScreen(),
                                          ),
                                          (route) => false,
                                        );
                                      }
                                    } catch (e) {
                                      authProvider.otpHasError = true;
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            margin: const EdgeInsets.all(6),
                                            backgroundColor: ConstantColors.kErrorBackgroundColor,
                                            shape: const RoundedRectangleBorder(
                                              side: BorderSide(color: ConstantColors.kErrorColor),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(6),
                                              ),
                                            ),
                                            content: Text(
                                              e.toString(),
                                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                    color: ConstantColors.kErrorColor,
                                                  ),
                                            ),
                                          ),
                                        );
                                      }
                                    } finally {
                                      // authProvider.setLoading = false;
                                    }
                                  },
                                ),
                                SizedBox(height: 8.h),
                                ExpandedOutlineButton(
                                  title: (authProvider.resendOtpRemainingDuration == 60) ? "Resend OTP" : "Resend in ${authProvider.resendOtpRemainingDuration} seconds",
                                  onTap: () async {
                                    if (!authProvider.isResendOtpEnabled) return;
                                    authProvider.otpHasError = false;
                                    FocusManager.instance.primaryFocus!.unfocus();
                                    try {
                                      // authProvider.setLoading = true;
                                      await authProvider.sendOtp(email: widget.email);
                                      authProvider.startResendOtpTimer();
                                    } on DioException catch (e) {
                                      authProvider.otpHasError = true;
                                      if (!mounted) return;
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            margin: const EdgeInsets.all(6),
                                            backgroundColor: ConstantColors.kErrorBackgroundColor,
                                            shape: const RoundedRectangleBorder(
                                              side: BorderSide(color: ConstantColors.kErrorColor),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(6),
                                              ),
                                            ),
                                            content: Text(
                                              e.response!.data['message'].toString(),
                                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                    color: ConstantColors.kErrorColor,
                                                  ),
                                            ),
                                          ),
                                        );
                                      }
                                    } finally {
                                      // authProvider.setLoading = false;
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            (context.watch<AuthProvider>().isLoading || context.watch<UserProvider>().isLoading) ? const UniversalLoadingWidget() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
