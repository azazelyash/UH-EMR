import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/colors.dart';

class SettingButtonWidget extends StatelessWidget {
  const SettingButtonWidget({
    super.key,
    required this.onTap,
    required this.title,
  });

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Material(
        color: ConstantColors.kTileBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.all(12.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(title, style: Theme.of(context).textTheme.headlineSmall),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: ConstantColors.kHeadlingColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
