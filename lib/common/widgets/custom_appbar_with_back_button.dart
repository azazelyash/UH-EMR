import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../features/dashboard/presentations/screens/doctor_dashboard_screen.dart';
import '../../features/user/presentation/providers/user_provider.dart';
import '../../gen/assets.gen.dart';
import '../../utils/constants/colors.dart';

class CustomAppBarWithBackButton extends StatelessWidget {
  const CustomAppBarWithBackButton({
    super.key,
    this.onTap,
    this.home,
  });

  final VoidCallback? onTap;
  final bool? home;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        (home ?? false)
            ? IconButton(
                onPressed: onTap ??
                    () {
                      Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(
                          builder: (context) => const DoctorDashboardScreen(),
                        ),
                        (route) => false,
                      );
                    },
                splashRadius: 20,
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                icon: const Icon(
                  Icons.home,
                  color: ConstantColors.kSecondaryColor,
                ),
              )
            : IconButton(
                onPressed: onTap ??
                    () {
                      Navigator.of(context).pop();
                    },
                splashRadius: 20,
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                icon: const Icon(
                  Icons.chevron_left_rounded,
                  color: ConstantColors.kHeadlingColor,
                ),
              ),
      ],
    );
  }
}
