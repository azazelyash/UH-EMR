import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/constants/colors.dart';
import '../../providers/rx_provider.dart';

class MedsValueDescriptionWidget extends StatelessWidget {
  const MedsValueDescriptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RxProvider>(
      builder: (context, rxProvider, child) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: ConstantColors.kSecondaryColor),
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffE9FDF3),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Meds Value: Rs. 1000!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ConstantColors.kSecondaryColor),
                ),
              ),
              SizedBox(height: 12.h),
              Text("Select Discount", textAlign: TextAlign.start, style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 8.h),
              Row(
                children: <Widget>[
                  // TODO: Choice Chips

                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        rxProvider.discountValue = 0;
                        rxProvider.discountFieldController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: (rxProvider.discountValue == 0)
                            ? ConstantColors.kSecondaryColor
                            : ConstantColors.kWhiteColor,
                      ),
                      child: Text(
                        "0 %",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: (rxProvider.discountValue == 0) ? ConstantColors.kWhiteColor : Colors.black54,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        rxProvider.discountValue = 5;
                        rxProvider.discountFieldController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: (rxProvider.discountValue == 5)
                            ? ConstantColors.kSecondaryColor
                            : ConstantColors.kWhiteColor,
                      ),
                      child: Text(
                        "5 %",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: (rxProvider.discountValue == 5) ? ConstantColors.kWhiteColor : Colors.black54,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        rxProvider.discountValue = 10;
                        rxProvider.discountFieldController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: (rxProvider.discountValue == 10)
                            ? ConstantColors.kSecondaryColor
                            : ConstantColors.kWhiteColor,
                      ),
                      child: Text(
                        "10 %",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: (rxProvider.discountValue == 10) ? ConstantColors.kWhiteColor : Colors.black54,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        controller: rxProvider.discountFieldController,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (value) {
                          rxProvider.discountValue = int.parse(value);
                          log(rxProvider.discountValue.toString());
                        },
                        decoration: const InputDecoration(hintText: "Custom"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
