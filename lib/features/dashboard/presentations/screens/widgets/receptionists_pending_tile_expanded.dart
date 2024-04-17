import '../../../../../common/widgets/expanded_elevated_button.dart';
import '../../../../../utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceptionistsPendingTileExpanded extends StatelessWidget {
  const ReceptionistsPendingTileExpanded({
    super.key,
    required this.index,
    required this.name,
    required this.date,
    required this.time,
    required this.completeFormalities,
  });

  final int index;
  final String name;
  final String date;
  final String time;
  final VoidCallback completeFormalities;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Name",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              "Contact",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "+91 95864 8065",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Last Date: ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(width: 4.w),
                Text(
                  date,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Last Date: ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(width: 4.w),
                Text(
                  time,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ExpandedElevatedButton(
          title: "View Rx and Lab Report",
          onTap: () {},
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: completeFormalities,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: ConstantColors.kErrorColor),
                  foregroundColor: ConstantColors.kErrorColor,
                ),
                child: const Text("Close"),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Send Rx in other Language"),
              ),
            ),
          ],
        )
      ],
    );
  }
}
