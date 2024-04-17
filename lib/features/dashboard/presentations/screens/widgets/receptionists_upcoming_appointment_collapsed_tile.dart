import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceptionistsUpcommingCollapsedWidget extends StatelessWidget {
  const ReceptionistsUpcommingCollapsedWidget({
    super.key,
    required this.index,
    required this.name,
    required this.date,
    required this.time,
    required this.priority,
    required this.enterOrEditButton,
  });

  final int index;
  final String name;
  final String date;
  final String time;
  final bool priority;
  final VoidCallback enterOrEditButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 6.w),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: Theme.of(context).textTheme.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  time,
                  style: Theme.of(context).textTheme.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 6.w),
          Expanded(
            flex: 5,
            child: Row(
              children: [
                (priority)
                    ? const Icon(
                        Icons.priority_high_rounded,
                        color: ConstantColors.kErrorColor,
                      )
                    : const SizedBox(width: 24),
                Expanded(
                  child: ElevatedButton(
                    onPressed: enterOrEditButton,
                    child: const Text("Enter/Edit Info"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
