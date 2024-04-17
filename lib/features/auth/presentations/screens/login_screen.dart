import 'package:aasa_emr/service/analytics.dart';

import '../../../../common/widgets/universal_loading_widget.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../utils/validators/validators.dart';
import '../../../../common/widgets/expanded_elevated_button.dart';
import '../providers/auth_provider.dart';
import 'otp_input_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "/";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

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
                    Assets.images.logo.image(width: 64),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 56.h),
                              Text(Strings.login, style: Theme.of(context).textTheme.titleLarge),
                              SizedBox(height: 24.h),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: emailController,
                                      validator: Validators.emailValidator,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      style: Theme.of(context).textTheme.bodyLarge,
                                      decoration: const InputDecoration(
                                        label: Text("Email"),
                                      ),
                                    ),
                                    // SizedBox(height: 16.h),
                                    // const Flex(
                                    //   direction: Axis.horizontal,
                                    //   children: [
                                    //     Expanded(child: Divider()),
                                    //     Padding(
                                    //       padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    //       child: Text("or"),
                                    //     ),
                                    //     Expanded(child: Divider()),
                                    //   ],
                                    // ),
                                    // SizedBox(height: 16.h),
                                    // TextFormField(
                                    //   // controller: emailController,
                                    //   // validator: Validators.emailValidator,
                                    //   keyboardType: TextInputType.number,
                                    //   textInputAction: TextInputAction.next,
                                    //   style: Theme.of(context).textTheme.bodyLarge,
                                    //   decoration: const InputDecoration(
                                    //     label: Text("Whatsapp Number"),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              ExpandedElevatedButton(
                                title: "Continue",
                                onTap: () async {
                                  if (!_formKey.currentState!.validate()) {
                                    // await context.read<UserProvider>().getUser();
                                    return;
                                  }
                                  FocusManager.instance.primaryFocus!.unfocus();
                                  try {
                                    // authProvider.setLoading = true;
                                    Analytics.logSendOtp();
                                    await authProvider.sendOtp(email: emailController.text.trim());
                                    if (!mounted) return;
                                    authProvider.startResendOtpTimer();
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => OtpInputScreen(
                                          email: emailController.text.trim(),
                                        ),
                                      ),
                                    );
                                  } catch (e) {
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
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            (context.watch<AuthProvider>().isLoading) ? const UniversalLoadingWidget() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
