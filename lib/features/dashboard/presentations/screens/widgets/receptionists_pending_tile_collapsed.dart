import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceptionistsPendingTileCollapsed extends StatelessWidget {
  const ReceptionistsPendingTileCollapsed({
    super.key,
    required this.name,
    required this.date,
    required this.time,
    required this.completeFormalities,
  });

  final String name;
  final String date;
  final String time;
  final VoidCallback completeFormalities;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            name,
            style: Theme.of(context).textTheme.bodyLarge,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          flex: 3,
          child: Wrap(
            direction: Axis.vertical,
            children: [
              Text(
                date,
                style: Theme.of(context).textTheme.bodyLarge,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                time,
                style: Theme.of(context).textTheme.bodyLarge,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
        SizedBox(width: 6.w),
        Expanded(
          flex: 5,
          child: ElevatedButton(
            onPressed: completeFormalities,
            child: const Text("Complete Formalites"),
          ),
        ),
      ],
    );
  }
}
