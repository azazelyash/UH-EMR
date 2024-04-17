import '../../../../../utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessMessageWidget extends StatelessWidget {
  const SuccessMessageWidget({
    super.key,
    required this.phone,
  });

  final String phone;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.verified_rounded,
          size: 64,
          color: ConstantColors.kSecondaryColor,
        ),
        SizedBox(height: 8.h),
        Text("Sent Successfully", style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(height: 4.h),
        Text(
          "Rx sent to the patient's mobile no. $phone",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
