import 'package:flutter/material.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RxInvoiceAdditionalNotes extends StatelessWidget {
  const RxInvoiceAdditionalNotes({
    super.key,
    this.content,
  });

  final String? content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 12.h),
        const DottedDashedLine(
          height: 1,
          width: double.infinity,
          axis: Axis.horizontal,
        ),
        SizedBox(height: 12.h),
        Text(
          "Additional Notes",
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 10.h),
        Text(
          content ?? "-",
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: 12.h),
        const DottedDashedLine(
          height: 1,
          width: double.infinity,
          axis: Axis.horizontal,
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
