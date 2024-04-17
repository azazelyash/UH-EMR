import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../common/widgets/custom_dropdown_widget.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../user/presentation/providers/user_provider.dart';

class RxFooterInfoWidget extends StatelessWidget {
  const RxFooterInfoWidget({
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
      child: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final footerMessage = userProvider.user.settings?.rxFormat?.footerInfo?.message;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Rx Footer Info",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 12.h),
              Row(
                children: <Widget>[
                  const Text("Current Message: "),
                  SizedBox(width: 8.w),
                  Text(
                    footerMessage ?? "-",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              TextFormField(
                decoration: const InputDecoration(hintText: "New Message"),
              ),
              SizedBox(height: 12.h),
              Row(
                children: <Widget>[
                  const Text("Signature Color:"),
                  SizedBox(width: 8.w),
                  SizedBox(
                    width: 120,
                    height: 32,
                    child: CustomDropdownWidget(
                      items: const ["Black", "White"],
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                      fillColor: ConstantColors.kWhiteColor,
                      iconColor: Colors.black54,
                      textColor: Colors.black54,
                      value: "White",
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
