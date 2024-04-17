import '../../../../../utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceptionistWidget extends StatelessWidget {
  const ReceptionistWidget({
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
                  "Receptionist",
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
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  "Receptionist 1",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              IconButton(
                onPressed: () {},
                splashRadius: 20,
                visualDensity: VisualDensity.compact,
                color: ConstantColors.kErrorColor,
                icon: const Icon(Icons.delete_outlined),
              )
            ],
          ),
          SizedBox(height: 8.h),
          TextFormField(
            decoration: const InputDecoration(hintText: "Name"),
          ),
          SizedBox(height: 12.h),
          TextFormField(
            decoration: const InputDecoration(hintText: "Contact"),
          ),
        ],
      ),
    );
  }
}
