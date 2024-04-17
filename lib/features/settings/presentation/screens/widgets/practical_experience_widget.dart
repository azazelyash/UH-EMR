import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PracticalExperience extends StatelessWidget {
  const PracticalExperience({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1, color: Colors.grey.shade400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Practical Experience",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 12.h),
          TextFormField(
            decoration: const InputDecoration(hintText: "Practical Experience"),
          ),
        ],
      ),
    );
  }
}
