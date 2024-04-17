import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/colors.dart';

class TestsTileWidget extends StatelessWidget {
  const TestsTileWidget({
    super.key,
    required this.items,
  });

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: ConstantColors.kTileBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(6),
                ),
                filled: true,
                fillColor: ConstantColors.kPrimaryColor,
              ),
              dropdownColor: ConstantColors.kWhiteColor,
              value: "Hydrochloroquinone Hydrochloroquinone 500mg",
              onChanged: (String? newValue) {},
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: ConstantColors.kWhiteColor,
                size: 18,
              ),
              selectedItemBuilder: (BuildContext context) => [
                "Hydrochloroquinone Hydrochloroquinone 500mg",
                "Hydrochloroquinone Hydrochloroquinone 600",
                "Hydrochloroquinone Hydrochloroquinone 700"
              ]
                  .map<Widget>(
                    (item) => SizedBox(
                      width: 180,
                      child: Text(
                        item,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ConstantColors.kWhiteColor),
                      ),
                    ),
                  )
                  .toList(),
              items: [
                "Hydrochloroquinone Hydrochloroquinone 500mg",
                "Hydrochloroquinone Hydrochloroquinone 600",
                "Hydrochloroquinone Hydrochloroquinone 700"
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.titleSmall!,
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            flex: 3,
            child: TextFormField(
              decoration: const InputDecoration(hintText: "Add Note"),
            ),
          ),
          IconButton(
            onPressed: () {
              // TODO: Delete Medicine or Test
            },
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            iconSize: 20,
            icon: const Icon(Icons.delete_outline_rounded),
            color: ConstantColors.kErrorColor,
          ),
        ],
      ),
    );
  }
}
