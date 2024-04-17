import '../../../../../utils/constants/colors.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConsumptionIndicatorWidget extends StatelessWidget {
  const ConsumptionIndicatorWidget({
    super.key,
    required this.morning,
    required this.noon,
    required this.night,
  });

  final bool morning;
  final bool noon;
  final bool night;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            color: (morning) ? Colors.black : ConstantColors.kRxPreviewColor,
            border: (morning) ? Border.all(width: 0, color: Colors.transparent) : Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        DottedDashedLine(
          height: 1,
          width: 16.w,
          axis: Axis.horizontal,
        ),
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            color: (noon) ? Colors.black : ConstantColors.kRxPreviewColor,
            border: (noon) ? Border.all(width: 0, color: Colors.transparent) : Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        DottedDashedLine(
          height: 1,
          width: 16.w,
          axis: Axis.horizontal,
        ),
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            color: (night) ? Colors.black : ConstantColors.kRxPreviewColor,
            border: (night) ? Border.all(width: 0, color: Colors.transparent) : Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
