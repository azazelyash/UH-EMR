import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants/colors.dart';
import 'package:flutter/material.dart';

class SendRxInOtherLanguage extends StatelessWidget {
  const SendRxInOtherLanguage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ConstantColors.kTileBackgroundColor,
        border: Border.all(color: ConstantColors.kPrimaryColor),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Send Rx in other Language",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 8.h),
          const Text("Select Rx Language"),
          SizedBox(height: 8.h),
          DropdownButtonFormField(
            hint: const Text("Select Rx Language"),
            items: const [
              DropdownMenuItem<String>(
                value: "Hindi",
                child: Text("Hindi"),
              ),
              DropdownMenuItem<String>(
                value: "English",
                child: Text("English"),
              ),
            ],
            onChanged: (val) {},
            value: "Hindi",
          ),
          SizedBox(height: 16.h),
          const Text("Add Emails and Mobile"),
          SizedBox(height: 8.h),
          TextFormField(
            decoration: const InputDecoration(
              hintText: "Separated by Commas \",\"",
            ),
          ),
          SizedBox(height: 8.h),
          TextButton.icon(
            onPressed: () {},
            label: const Text("Print"),
            icon: const Icon(Icons.print_outlined),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text("To Main Contacts"),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("To Other Contacts"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
