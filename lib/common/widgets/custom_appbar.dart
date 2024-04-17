import 'dart:developer';

import 'package:aasa_emr/features/dashboard/presentations/screens/choose_clinic_screen.dart';
import 'package:aasa_emr/service/analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../features/auth/presentations/providers/auth_provider.dart';
import '../../features/auth/presentations/screens/login_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/user/presentation/providers/user_provider.dart';
import '../../gen/assets.gen.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/strings.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Assets.images.logo.image(width: 48.sp),
        SizedBox(width: 16.w),
        Expanded(
          child: Consumer<UserProvider>(builder: (context, userProvider, child) {
            final user = userProvider.user;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (user.profile?.name != null) ...[
                  Text(
                    "Dr. ${user.profile?.name}'s Practice",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall,
                    maxLines: 2,
                  ),
                ],
              ],
            );
          }),
        ),
        SizedBox(width: 8.w),
        PopupMenuButton(
          iconColor: ConstantColors.kSecondaryColor,
          icon: const Icon(Icons.person),
          tooltip: "Menu",
          splashRadius: 20,
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: () {},
              child: Text(Strings.notifications),
            ),
            PopupMenuItem(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(
                    builder: (context) => const ChooseClinicScreen(),
                  ),
                  (route) => false,
                );
                // Navigator.of(context).pop();
              },
              child: Text(Strings.chooseClinic),
            ),
            PopupMenuItem(
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              child: Text(Strings.settings),
            ),
            PopupMenuItem(
              onTap: () async {
                try {
                  Analytics.logLogout();

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
