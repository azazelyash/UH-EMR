import 'dart:developer';

import '../../../../../utils/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class IndicatorChip extends StatelessWidget {
  const IndicatorChip({
    super.key,
    this.icon,
    required this.color,
    required this.title,
    required this.showButton,
    required this.backgroundColor,
  });

  final Color color;
  final Color backgroundColor;
  final String title;
  final IconData? icon;
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!showButton) return;
        log(title);
      },
      child: Container(
        padding: EdgeInsets.all(4.sp),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            (!showButton && icon != null)
                ? Container(
                    padding: EdgeInsets.all(2.sp),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Icon(icon, color: ConstantColors.kWhiteColor, size: 12.sp),
                  )
                : const SizedBox(),
            SizedBox(width: 4.w),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            (showButton)
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.sp),
                    child: Icon(Icons.open_in_new_rounded, color: color, size: 12.sp),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
