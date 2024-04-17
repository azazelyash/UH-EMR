import 'package:aasa_emr/common/helper/utils.dart';
import 'package:aasa_emr/common/widgets/expanded_elevated_button.dart';
import 'package:aasa_emr/features/settings/data/model/medicine.dart';
import 'package:aasa_emr/features/settings/presentation/providers/medication_provider.dart';
import 'package:aasa_emr/features/user/data/models/settings_model.dart';
import 'package:aasa_emr/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

class AddMedicineDialogWidget extends StatefulWidget {
  const AddMedicineDialogWidget({
    super.key,
    this.onMedSelected,
    this.onTapAdd,
  });

  final Function(Medicine?)? onMedSelected;
  final VoidCallback? onTapAdd;

  @override
  State<AddMedicineDialogWidget> createState() => _AddMedicineDialogWidgetState();
}

class _AddMedicineDialogWidgetState extends State<AddMedicineDialogWidget> {
  MedicineDetailsModel medicineDetailsModel = MedicineDetailsModel(
    medicineType: "Tablet",
    intakeDetails: IntakeDetailsModel(
      foodTime: "Before Food",
      intake: [],
    ),
  );

  TextEditingController newMedicineController = TextEditingController();
  Medicine? selectedMedicine;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      content: SizedBox(
        width: 560.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Add Medicine"),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                  splashRadius: 20,
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                )
              ],
            ),
            SizedBox(height: 12.h),
            Container(
              decoration: BoxDecoration(
                color: ConstantColors.kWhiteColor,
                border: Border.all(color: ConstantColors.kHeadlingColor),
                borderRadius: BorderRadius.circular(6),
              ),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              child: Theme(
                data: ThemeData(useMaterial3: false),
                child: SearchableDropdown<Medicine>.paginated(
                  hintText: const Text("Search Medicine"),
                  onChanged: widget.onMedSelected ??
                      (medicine) {
                        context.read<MedicationProvider>().selectedMedicine = medicine;
                      },
                  paginatedRequest: (int pageKey, String? searchKey) async {
                    final paginatedList = await context.read<MedicationProvider>().getAllMedicine(
                          page: pageKey,
                          searchKey: searchKey,
                        );
                    return paginatedList
                        .map(
                          (medicine) => SearchableDropdownMenuItem(
                            value: medicine,
                            label: medicine.productName ?? '',
                            onTap: () {
                              // medicineDetailsModel.medicineName = medicine.productName!;
                              context.read<MedicationProvider>().selectedMedicine = medicine;
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${medicine.productName}",
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList();
                  },
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: <Widget>[
                const Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    "Or",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: newMedicineController,
              decoration: const InputDecoration(
                label: Text("New Medicine"),
              ),
            ),
            SizedBox(height: 12.h),
            ExpandedElevatedButton(
              onTap: widget.onTapAdd ??
                  () {
                    if (context.read<MedicationProvider>().selectedMedicine != null &&
                        newMedicineController.text != "") {
                      Utils.showSnackBar(context, content: "Please remove the selected medicine to add new medicine.");
                    } else if (context.read<MedicationProvider>().selectedMedicine != null) {
                      medicineDetailsModel.medicineName =
                          context.read<MedicationProvider>().selectedMedicine!.productName;
                      Navigator.of(context).pop(medicineDetailsModel);
                    } else if (newMedicineController.text != "") {
                      medicineDetailsModel.medicineName = newMedicineController.text;
                      Navigator.of(context).pop(medicineDetailsModel);
                    } else {
                      Utils.showSnackBar(context, content: "You have no medicine selected.");
                    }
                  },
              title: "Add",
            ),
          ],
        ),
      ),
    );
  }
}
