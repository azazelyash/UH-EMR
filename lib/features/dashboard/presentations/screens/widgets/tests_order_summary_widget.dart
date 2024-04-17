import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/colors.dart';
import 'bills_detail_widget.dart';
import 'indicator_chip.dart';

class TestsOrderSummaryWidget extends StatelessWidget {
  const TestsOrderSummaryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ConstantColors.kWhiteColor,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tests Order #1283",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Track Tests",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ConstantColors.kSecondaryColor),
                  ),
                  SizedBox(width: 4.w),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: ConstantColors.kSecondaryColor,
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            "Report Expected: 4pm, today",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ConstantColors.kSecondaryColor),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Text("Status:"),
                  SizedBox(width: 4.w),
                  IndicatorChip(
                    color: ConstantColors.kPrimaryColor,
                    backgroundColor: Colors.blue.shade50,
                    showButton: false,
                    title: "In Process",
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Order Total:"),
                  SizedBox(width: 8.w),
                  Text(
                    "Rs. 1000",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            "View Bill",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 2.h),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return const BillDetailsWidget(title: "Patient's Meds Bill");
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: ConstantColors.kSecondaryColor),
                  child: const Text("Your Purchase Bill"),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return const BillDetailsWidget(title: "Patient's Meds Bill");
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: ConstantColors.kSecondaryColor),
                  child: const Text("Patient Bill"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
