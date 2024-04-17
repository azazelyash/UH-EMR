import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/constants/colors.dart';
import 'package:flutter/material.dart';

class RxHeaderInfoTile extends StatelessWidget {
  final String vitalName;
  final bool isCheckBoxSelected;
  final void Function(bool? value) onCheckboxSelected;

  const RxHeaderInfoTile(
      {super.key, required this.vitalName, required this.isCheckBoxSelected, required this.onCheckboxSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: ConstantColors.kTileBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: SizedBox(
              height: 32, child: Text(vitalName),
              // CustomDropdownWidget(
              //   items: ['Name', 'Number', 'Age', 'Height'],
              //   value: "Name",
              //   borderSide: BorderSide(color: Colors.black45),
              //   fillColor: ConstantColors.kWhiteColor,
              //   iconColor: Colors.black54,
              //   textColor: Colors.black54,
              // ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Checkbox(
              value: isCheckBoxSelected,
              onChanged: onCheckboxSelected,
            ),
          ),
          // IconButton(
          //   icon: const Icon(Icons.close),
          //   visualDensity: VisualDensity.compact,
          //   onPressed: () {},
          //   padding: EdgeInsets.zero,
          // ),
        ],
      ),
    );
  }
}
