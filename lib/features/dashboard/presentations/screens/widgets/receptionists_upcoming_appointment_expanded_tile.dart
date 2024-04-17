import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/colors.dart';

class ReceptionistsUpcommingExpanededWidget extends StatelessWidget {
  const ReceptionistsUpcommingExpanededWidget({
    super.key,
    required this.name,
    required this.index,
    required this.doctor,
    required this.doneButton,
  });

  final int index;
  final String name;
  final String doctor;
  final VoidCallback doneButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Name",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "Contact",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "98765 43201",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: <Widget>[
              Text(
                "Doctor:",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(width: 4.w),
              Text(
                doctor,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      flex: 2,
                      child: Text("Edit Date: "),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 32,
                        child: TextFormField(
                          keyboardType: TextInputType.none,
                          showCursor: false,
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              lastDate: DateTime.now().add(const Duration(days: 700)),
                              firstDate: DateTime.now(),
                            );
                          },
                          decoration: InputDecoration(
                            hintText: "Edit Date",
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      flex: 2,
                      child: Text("Edit Time: "),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 32,
                        child: TextFormField(
                          keyboardType: TextInputType.none,
                          showCursor: false,
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                          },
                          decoration: InputDecoration(
                            hintText: "Edit Time",
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      flex: 1,
                      child: Text("Height: "),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 32,
                        child: TextFormField(
                          keyboardType: TextInputType.none,
                          showCursor: false,
                          onTap: () {},
                          decoration: InputDecoration(
                            hintText: "Edit Date",
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      flex: 1,
                      child: Text("BP: "),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 32,
                        child: TextFormField(
                          keyboardType: TextInputType.none,
                          showCursor: false,
                          onTap: () {},
                          decoration: InputDecoration(
                            hintText: "Edit Date",
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      flex: 1,
                      child: Text("Weight: "),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 32,
                        child: TextFormField(
                          keyboardType: TextInputType.none,
                          showCursor: false,
                          onTap: () {},
                          decoration: InputDecoration(
                            hintText: "Edit Date",
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      flex: 1,
                      child: Text("Pulse: "),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 32,
                        child: TextFormField(
                          keyboardType: TextInputType.none,
                          showCursor: false,
                          onTap: () {},
                          decoration: InputDecoration(
                            hintText: "Edit Date",
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: ConstantColors.kErrorColor),
                    foregroundColor: ConstantColors.kErrorColor,
                    surfaceTintColor: ConstantColors.kErrorColor,
                  ),
                  child: const Text("Cancel Consultation"),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: doneButton,
                  child: const Text("Done"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
