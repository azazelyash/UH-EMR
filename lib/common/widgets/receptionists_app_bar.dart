import 'dart:developer';

import 'package:aasa_emr/features/auth/presentations/providers/auth_provider.dart';
import 'package:aasa_emr/features/auth/presentations/screens/login_screen.dart';
import 'package:aasa_emr/features/dashboard/presentations/providers/appointment_provider.dart';
import 'package:aasa_emr/features/dashboard/presentations/screens/choose_clinic_screen.dart';
import 'package:aasa_emr/features/user/data/models/user_model.dart';
import 'package:aasa_emr/utils/constants/colors.dart';
import 'package:aasa_emr/utils/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../gen/assets.gen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/user/presentation/providers/user_provider.dart';

class ReceptionistsAppBar extends StatefulWidget {
  const ReceptionistsAppBar({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  State<ReceptionistsAppBar> createState() => _ReceptionistsAppBarState();
}

class _ReceptionistsAppBarState extends State<ReceptionistsAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Assets.images.logo.image(width: 48.sp),
        SizedBox(width: 16.w),
        Expanded(
          child: Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              final user = userProvider.user;

              return (user.listOfDoctors!.isNotEmpty)
                  ? DropdownButtonFormField(
                      items: userProvider.doctorsAssociatedWithSelectedClinic!.map((doctor) {
                        return DropdownMenuItem<User>(
                          value: doctor,
                          child: Text(
                            doctor.profile?.name ?? "-",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        );
                      }).toList(),
                      selectedItemBuilder: (context) => userProvider.doctorsAssociatedWithSelectedClinic!.map((doctor) {
                        return DropdownMenuItem<User>(
                          value: doctor,
                          child: Text(
                            doctor.profile?.name ?? "-",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        );
                      }).toList(),
                      isDense: false,
                      isExpanded: true,
                      menuMaxHeight: 320.h,
                      value: userProvider.doctorsAssociatedWithSelectedClinic![0],
                      onChanged: (newDoctor) {
                        userProvider.selectedDoctor = newDoctor;
                        context.read<AppointmentProvider>().upcomingAppointmentController.refresh();
                        context.read<AppointmentProvider>().previousAppointmentController.refresh();
                      },
                    )
                  : Text(
                      "No Doctors Found",
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
            },
          ),
        ),
        PopupMenuButton(
          iconColor: ConstantColors.kSecondaryColor,
          icon: const Icon(Icons.person),
          tooltip: "Menu",
          splashRadius: 20,
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(
                    builder: (context) => const ChooseClinicScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Text(Strings.chooseClinic),
            ),
            PopupMenuItem(
              onTap: () async {
                try {
                  await context.read<AuthProvider>().signOut();

                  if (context.mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  }
                  await Future.delayed(const Duration(seconds: 1));
                  if (context.mounted) {
                    context.read<UserProvider>().makeUserEmpty();
                  }
                } catch (e) {
                  log(e.toString());
                }
              },
              child: Text(Strings.logout),
            ),
          ],
        ),
      ],
    );
  }
}
