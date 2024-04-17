import '../../../../../utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderNowWidget extends StatelessWidget {
  const OrderNowWidget({
    super.key,
    required this.orderNowButton,
  });

  final VoidCallback orderNowButton;

  @override
  Widget build(BuildContext context) {
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
              "Order Now",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            decoration: const InputDecoration(hintText: "Add patient address"),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: CheckboxListTile(
                  value: true,
                  onChanged: (value) {},
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "Order Medicine",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ConstantColors.kHeadlingColor),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CheckboxListTile(
                  value: true,
                  onChanged: (value) {},
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "Order Tests",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ConstantColors.kHeadlingColor),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: orderNowButton,
              style: ElevatedButton.styleFrom(backgroundColor: ConstantColors.kSecondaryColor),
              icon: const Icon(
                Icons.delivery_dining_outlined,
              ),
              label: const Text("Place Order"),
            ),
          ),
        ],
      ),
    );
  }
}
