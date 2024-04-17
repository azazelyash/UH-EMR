// ignore_for_file: deprecated_member_use_from_same_package

import 'package:aasa_emr/features/rx_screen/presentation/providers/rx_provider.dart';
import 'package:aasa_emr/features/user/presentation/providers/user_provider.dart';
import 'package:aasa_emr/gen/assets.gen.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:provider/provider.dart';

import '../../features/user/data/models/settings_model.dart';
import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import 'dosage_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class MedicinesTileWidget extends StatefulWidget {
  const MedicinesTileWidget({
    super.key,
    required this.index,
    required this.onChanged,
    this.onChangeMedicineType,
    required this.noteController,
    required this.medicineDetails,
    this.setMorning,
    this.setNoon,
    this.setNight,
    this.onTapDelete,
  });

  final int index;
  final Function(bool) onChanged;
  final Function(dynamic)? onChangeMedicineType;
  final MedicineDetailsModel medicineDetails;
  final TextEditingController noteController;
  final Function(bool?)? setMorning;
  final Function(bool?)? setNoon;
  final Function(bool?)? setNight;
  final VoidCallback? onTapDelete;

  @override
  State<MedicinesTileWidget> createState() => _MedicinesTileWidgetState();
}

class _MedicinesTileWidgetState extends State<MedicinesTileWidget> {
  List<String?>? frequencies;
  List<String?>? medicines;

  @override
  void initState() {
    super.initState();
    frequencies = context.read<UserProvider>().dropdownValues!.frequencies!.map((e) => e.value).toList();
    medicines = context.read<UserProvider>().dropdownValues!.medicineTypes!.map((e) => e.value).toList();

    if (!frequencies!.contains(widget.medicineDetails.intakeDetails!.amount) &&
        widget.medicineDetails.intakeDetails!.amount != null) {
      frequencies!.add(widget.medicineDetails.intakeDetails!.amount);
    }
  }

  DropdownController dropdownController = DropdownController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: ConstantColors.kTileBackgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.medicineDetails.medicineName!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                child: CoolDropdown(
                  onChange: widget.onChangeMedicineType ?? (value) {},
                  defaultItem: CoolDropdownItem(
                    label: widget.medicineDetails.medicineType ?? "Syrup",
                    value: widget.medicineDetails.medicineType ?? "Syrup",
                    icon: (widget.medicineDetails.medicineType == "Syrup")
                        ? Assets.svg.syrup.svg(
                            color: Colors.black,
                            height: 20,
                            width: 20,
                          )
                        : (widget.medicineDetails.medicineType == "Injection")
                            ? Assets.svg.injection.svg(
                                color: Colors.black,
                                height: 20,
                                width: 20,
                              )
                            : (widget.medicineDetails.medicineType == "Tablet")
                                ? Assets.svg.tablet.svg(
                                    color: Colors.black,
                                    height: 20,
                                    width: 20,
                                  )
                                : (widget.medicineDetails.medicineType == "Capsule")
                                    ? Assets.svg.capsule.svg(
                                        color: Colors.black,
                                        height: 20,
                                        width: 20,
                                      )
                                    : (widget.medicineDetails.medicineType == "Inhaler")
                                        ? Assets.svg.inhaler.svg(
                                            color: Colors.black,
                                            height: 20,
                                            width: 20,
                                          )
                                        : Assets.svg.powder.svg(
                                            color: Colors.black,
                                            height: 20,
                                            width: 20,
                                          ),
                  ),
                  resultOptions: ResultOptions(
                    height: 52,
                    boxDecoration: BoxDecoration(
                      color: ConstantColors.kWhiteColor,
                      border: Border.all(
                        color: ConstantColors.kPrimaryColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                  ),
                  dropdownTriangleOptions: const DropdownTriangleOptions(height: 0, width: 0),
                  dropdownOptions: const DropdownOptions(animationType: DropdownAnimationType.size),
                  dropdownItemOptions: const DropdownItemOptions(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    height: 52,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  dropdownList: medicines!
                      .map(
                        (item) => CoolDropdownItem(
                          label: item.toString(),
                          value: item.toString(),
                          icon: (item == "Syrup")
                              ? Assets.svg.syrup.svg(
                                  color: Colors.black,
                                  height: 20,
                                  width: 20,
                                )
                              : (item == "Injection")
                                  ? Assets.svg.injection.svg(
                                      color: Colors.black,
                                      height: 20,
                                      width: 20,
                                    )
                                  : (item == "Tablet")
                                      ? Assets.svg.tablet.svg(
                                          color: Colors.black,
                                          height: 20,
                                          width: 20,
                                        )
                                      : (item == "Capsule")
                                          ? Assets.svg.capsule.svg(
                                              color: Colors.black,
                                              height: 20,
                                              width: 20,
                                            )
                                          : (item == "Inhaler")
                                              ? Assets.svg.inhaler.svg(
                                                  color: Colors.black,
                                                  height: 20,
                                                  width: 20,
                                                )
                                              : Assets.svg.powder.svg(
                                                  color: Colors.black,
                                                  height: 20,
                                                  width: 20,
                                                ),
                        ),
                      )
                      .toList(),
                  controller: dropdownController,
                ),
              ),
              // Theme(
              //   data: ThemeData(),
              //   child: CustomDropdown(
              //     items: medicines,
              //     initialItem: medicines![0],
              //     // initialItem: "${widget.medicineDetails.medicineName} - ${widget.medicineDetails.medicineType ?? "Tablet"}",
              //     onChanged: (value) {},
              //     decoration: CustomDropdownDecoration(
              //       closedFillColor: ConstantColors.kPrimaryColor,
              //       headerStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              //             color: ConstantColors.kWhiteColor,
              //           ),
              //       hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              //             color: ConstantColors.kWhiteColor,
              //           ),
              //       closedSuffixIcon: const Icon(
              //         Icons.keyboard_arrow_down_rounded,
              //         color: ConstantColors.kWhiteColor,
              //       ),
              //       expandedBorderRadius: BorderRadius.circular(6),
              //       closedBorderRadius: BorderRadius.circular(6),
              //     ),
              //   ),
              // ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Theme(
                      data: ThemeData(),
                      child: CustomDropdown<String>(
                        items:
                            List.generate(1000, (index) => (index + 1 == 1) ? "${index + 1} Day" : "${index + 1} Days"),
                        initialItem: widget.medicineDetails.intakeDetails!.days,
                        maxlines: 2,
                        closedHeaderPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 6.w),
                        hintText: "Duration",
                        hideSelectedFieldWhenExpanded: true,
                        decoration: CustomDropdownDecoration(
                          closedBorder: Border.all(color: ConstantColors.kErrorColor),
                          closedBorderRadius: BorderRadius.circular(6.r),
                          expandedBorderRadius: BorderRadius.circular(6.r),
                        ),
                        onChanged: (value) {
                          widget.medicineDetails.intakeDetails!.days = value;
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    flex: 2,
                    child: Theme(
                      data: ThemeData(),
                      child: CustomDropdown<String?>(
                        items: frequencies,
                        // items: context.read<UserProvider>().dropdownValues!.frequencies!.map((e) => e.value).toList(),
                        initialItem: widget.medicineDetails.intakeDetails!.amount,
                        maxlines: 2,
                        hintText: "Frequency",
                        closedHeaderPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 6.w),
                        hideSelectedFieldWhenExpanded: true,
                        decoration: CustomDropdownDecoration(
                          closedBorder: Border.all(color: ConstantColors.kSecondaryColor),
                          closedBorderRadius: const BorderRadius.all(Radius.circular(6)),
                          expandedBorderRadius: const BorderRadius.all(Radius.circular(6)),
                        ),
                        onChanged: (value) {
                          widget.medicineDetails.intakeDetails!.amount = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: DosageWidget(
                      index: widget.index,
                      setMorning: widget.setMorning,
                      setNoon: widget.setNoon,
                      setNight: widget.setNight,
                      intakeDetails: widget.medicineDetails.intakeDetails ?? IntakeDetailsModel(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          (widget.medicineDetails.intakeDetails?.foodTime != null)
                              ? widget.medicineDetails.intakeDetails!.foodTime!
                              : "Before Food",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(width: 4.w),
                        Switch(
                          value: (widget.medicineDetails.intakeDetails?.foodTime != null &&
                                  widget.medicineDetails.intakeDetails!.foodTime == "Before Food")
                              ? false
                              : true,
                          onChanged: widget.onChanged,
                          inactiveTrackColor: ConstantColors.kPrimaryColor,
                          activeTrackColor: ConstantColors.kSecondaryColor,
                          activeColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 32.h,
                      child: TextFormField(
                        controller: widget.noteController,
                        // controller: context.watch<RxProvider>().noteControllers[widget.index],
                        decoration: const InputDecoration(hintText: "Add Note"),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: widget.onTapDelete ??
                        () {
                          context.read<RxProvider>().deleteMedicine(widget.index);
                        },
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    iconSize: 20.sp,
                    splashRadius: 16.sp,
                    icon: const Icon(Icons.delete_outline_rounded),
                    color: ConstantColors.kErrorColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
