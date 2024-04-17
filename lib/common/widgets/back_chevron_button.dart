import '../../utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackChevronButton extends StatelessWidget {
  const BackChevronButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: ConstantColors.kWhiteColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.chevron_left_rounded,
                color: ConstantColors.kPrimaryColor,
              ),
              Text(
                "Back",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ConstantColors.kPrimaryColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
