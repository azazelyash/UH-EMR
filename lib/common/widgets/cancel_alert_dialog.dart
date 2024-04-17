import 'package:aasa_emr/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelPopupWidget extends StatelessWidget {
  const CancelPopupWidget({
    super.key,
    required this.confirmButtonFunction,
    required this.content,
  });

  final String content;
  final VoidCallback confirmButtonFunction;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: ConstantColors.kErrorColor,
            foregroundColor: ConstantColors.kWhiteColor,
            child: Icon(
              Icons.close_rounded,
              size: 44,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            content,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No"),
                ),
              ),
              SizedBox(
                width: 10.h,
              ),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                  ),
                  onPressed: confirmButtonFunction,
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
