import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RxSuccessAlertDialogWidget extends StatelessWidget {
  const RxSuccessAlertDialogWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.only(left: 12.w, right: 12.w, top: 10.w),
      contentPadding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 10.w, top: 10.w),
      actionsPadding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 10.w),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            splashRadius: 20,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            Icons.info,
            size: 56,
            color: Colors.amber,
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: <Widget>[
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("No"),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(child: ElevatedButton(onPressed: () {}, child: const Text("Yes"))),
            ],
          )
        ],
      ),
    );
  }
}
