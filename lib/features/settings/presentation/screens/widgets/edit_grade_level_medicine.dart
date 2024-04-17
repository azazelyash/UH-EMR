import 'package:aasa_emr/common/constants/intake_constants.dart';
import 'package:aasa_emr/common/widgets/add_medicine_dialog_widget.dart';
import 'package:aasa_emr/features/settings/presentation/providers/medication_provider.dart';
import 'package:provider/provider.dart';

import '../../../../user/data/models/settings_model.dart';
import '../../../../../common/widgets/medicines_tile.dart';
import 'package:flutter/material.dart';

class EditGradeLevelMedicine extends StatefulWidget {
  const EditGradeLevelMedicine({
    super.key,
    required this.grade,
  });

  final String grade;
  // final MedicationModel mediciation;

  @override
  State<EditGradeLevelMedicine> createState() => _EditGradeLevelMedicineState();
}

class _EditGradeLevelMedicineState extends State<EditGradeLevelMedicine> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MedicationProvider>(
      builder: (context, medicationProvider, child) {
        return CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: medicationProvider.gradeMedicinesListLength(widget.grade),
                (context, index) {
                  return MedicinesTileWidget(
                    index: index,
                    onChangeMedicineType: (medicineType) {
                      medicationProvider.editMedicineType(index, widget.grade, medicineType);
                    },
                    onChanged: (value) {
                      medicationProvider.editMedicineIntake(index, widget.grade);
                    },
                    setMorning: (val) {
                      medicationProvider.addIntakeDosage(widget.grade, index, IntakeConstants.morning);
                    },
                    setNoon: (val) {
                      medicationProvider.addIntakeDosage(widget.grade, index, IntakeConstants.noon);
                    },
                    setNight: (val) {
                      medicationProvider.addIntakeDosage(widget.grade, index, IntakeConstants.night);
                    },
                    onTapDelete: () {
                      medicationProvider.removeMedicineFromList(grade: widget.grade, index: index);
                    },
                    noteController: medicationProvider.getGradeController(widget.grade)[index],
                    medicineDetails: medicationProvider.getGradeMedicines(widget.grade)[index],
                  );
                },
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverList.list(
                children: [
                  OutlinedButton(
                    child: const Text("Add New Medicine"),
                    onPressed: () async {
                      MedicineDetailsModel? newMedicine = await showDialog(
                        context: context,
                        builder: (context) => const AddMedicineDialogWidget(),
                      );
                      if (newMedicine != null) {
                        medicationProvider.addGradeMedicine(widget.grade, newMedicine);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
