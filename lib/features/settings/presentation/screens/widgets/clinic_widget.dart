import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/colors.dart';
import 'browse_image_tile.dart';

class ClinicWidget extends StatelessWidget {
  const ClinicWidget({
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  "Clinic",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: ConstantColors.kSecondaryColor),
                  label: const Text("Add"),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          TextFormField(
            decoration: const InputDecoration(hintText: "Name"),
          ),
          SizedBox(height: 12.h),
          TextFormField(
            decoration: const InputDecoration(hintText: "Address"),
          ),
          SizedBox(height: 12.h),
          TextFormField(
            decoration: const InputDecoration(hintText: "Contact"),
          ),
          SizedBox(height: 12.h),
          const BrowseImageTile(title: "Clinic Logo")
        ],
      ),
    );
  }
}
