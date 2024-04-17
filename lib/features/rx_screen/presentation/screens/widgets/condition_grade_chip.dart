import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConditionGradeChip extends StatelessWidget {
  const ConditionGradeChip({
    super.key,
    required this.grade,
  });

  final String grade;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (grade == "Grade 1")
            ? Colors.blue.shade100
            : (grade == "Grade 2")
                ? Colors.yellow.shade100
                : Colors.red.shade100,
        border: Border.all(
          color: (grade == "Grade 1")
              ? Colors.blue.shade900
              : (grade == "Grade 2")
                  ? Colors.yellow.shade900
                  : Colors.red.shade900,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      // padding: EdgeInsets.all(2),
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Text(
        grade,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: (grade == "Grade 1")
                  ? Colors.blue.shade900
                  : (grade == "Grade 2")
                      ? Colors.yellow.shade900
                      : Colors.red.shade900,
            ),
      ),
    );
  }
}
