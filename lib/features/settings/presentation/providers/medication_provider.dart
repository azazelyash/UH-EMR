import 'package:aasa_emr/features/settings/domain/usecase/update_user_usercase.dart';
import 'package:aasa_emr/features/user/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:aasa_emr/common/provider/loading_provider.dart';
import 'package:aasa_emr/features/settings/data/model/medicine.dart';
import 'package:aasa_emr/features/user/data/models/settings_model.dart';
import 'package:aasa_emr/features/settings/domain/usecase/get_all_medicine_usecase.dart';

class MedicationProvider extends LoadingProvider {
  MedicineDetailsModel newMedicine = MedicineDetailsModel();
  final GetAllMedicineUseCase getAllMedicineUseCase;
  final UpdateUserUseCase updateUserUseCase;

  MedicationProvider({
    required this.getAllMedicineUseCase,
    required this.updateUserUseCase,
  });

  List<RxTemplate>? _rxTemplates = [];
  List<RxTemplate>? get rxTemplate => _rxTemplates;

  List<MedicineDetailsModel>? prescribedMedicines = [];
  List<MedicineDetailsModel>? _grade1Meds = [];
  List<MedicineDetailsModel>? _grade2Meds = [];
  List<MedicineDetailsModel>? _grade3Meds = [];

  List<MedicineDetailsModel>? get grade1Meds => _grade1Meds;
  List<MedicineDetailsModel>? get grade2Meds => _grade2Meds;
  List<MedicineDetailsModel>? get grade3Meds => _grade3Meds;

  List<TextEditingController> grade1NotesControllers = [];
  List<TextEditingController> grade2NotesControllers = [];
  List<TextEditingController> grade3NotesControllers = [];

  Medicine? _selectedMedicine;
  Medicine? get selectedMedicine => _selectedMedicine;

  List<TextEditingController> _noteControllers = [];
  List<TextEditingController> get noteControllers => _noteControllers;

  set selectedMedicine(Medicine? value) {
    _selectedMedicine = value;
    notifyListeners();
  }

  set noteControllers(List<TextEditingController> value) {
    _noteControllers = value;
    notifyListeners();
  }

  set rxTemplate(List<RxTemplate>? value) {
    _rxTemplates = value;
    notifyListeners();
  }

  set grade1Meds(List<MedicineDetailsModel>? value) {
    _grade1Meds = value;
    notifyListeners();
  }

  set grade2Meds(List<MedicineDetailsModel>? value) {
    _grade2Meds = value;
    notifyListeners();
  }

  set grade3Meds(List<MedicineDetailsModel>? value) {
    _grade3Meds = value;
    notifyListeners();
  }

  void addRxTemplates(List<RxTemplate> data) {
    _rxTemplates?.addAll(data);
    notifyListeners();
  }

  void addNewCondition(RxTemplate newRx) {
    _rxTemplates!.add(newRx);
    notifyListeners();
  }

  void resetConditions(List<RxTemplate> data) {
    _rxTemplates!.clear();
    _rxTemplates!.addAll(data);

    notifyListeners();
  }

  void generateControllers() {
    noteControllers = List.generate(
      prescribedMedicines!.length,
      (index) => TextEditingController(),
    );
    notifyListeners();
  }

  void emptyAllVariables() {
    _grade1Meds?.clear();
    _grade2Meds?.clear();
    _grade3Meds?.clear();
    grade1NotesControllers.clear();
    grade2NotesControllers.clear();
    grade3NotesControllers.clear();
    notifyListeners();
  }

  List<MedicineDetailsModel> updateMedicine(String grade) {
    List<MedicineDetailsModel> updatedMedicineDetailsList = [];
    if (grade.toLowerCase() == "grade 1") {
      for (int i = 0; i < grade1Meds!.length; i++) {
        MedicineDetailsModel updatedMedicineDetails = grade1Meds![i].copyWith(
          message: grade1NotesControllers[i].text,
        );
        updatedMedicineDetailsList.add(updatedMedicineDetails);
      }
    } else if (grade.toLowerCase() == "grade 2") {
      for (int i = 0; i < grade2Meds!.length; i++) {
        MedicineDetailsModel updatedMedicineDetails = grade2Meds![i].copyWith(
          message: grade2NotesControllers[i].text,
        );
        updatedMedicineDetailsList.add(updatedMedicineDetails);
      }
    } else if (grade.toLowerCase() == "grade 3") {
      for (int i = 0; i < grade3Meds!.length; i++) {
        MedicineDetailsModel updatedMedicineDetails = grade3Meds![i].copyWith(
          message: grade3NotesControllers[i].text,
        );
        updatedMedicineDetailsList.add(updatedMedicineDetails);
      }
    }
    return updatedMedicineDetailsList;
  }

  void initialiseMeds(MedicationModel medicationModel) {
    if (medicationModel.grade?.toLowerCase() == "grade 1") {
      _grade1Meds?.addAll(medicationModel.medicineDetails);
      grade1NotesControllers.addAll(
        List<TextEditingController>.generate(
          medicationModel.medicineDetails.length,
          (index) => TextEditingController(text: medicationModel.medicineDetails[index].message),
        ),
      );
    } else if (medicationModel.grade?.toLowerCase() == "grade 2") {
      _grade2Meds?.addAll(medicationModel.medicineDetails);
      grade2NotesControllers.addAll(
        List<TextEditingController>.generate(
          medicationModel.medicineDetails.length,
          (index) => TextEditingController(text: medicationModel.medicineDetails[index].message),
        ),
      );
    } else if (medicationModel.grade?.toLowerCase() == "grade 3") {
      _grade3Meds?.addAll(medicationModel.medicineDetails);
      grade3NotesControllers.addAll(
        List<TextEditingController>.generate(
          medicationModel.medicineDetails.length,
          (index) => TextEditingController(text: medicationModel.medicineDetails[index].message),
        ),
      );
    }
    notifyListeners();
  }

  int gradeMedicinesListLength(String grade) {
    if (grade.toLowerCase() == "grade 1") {
      return grade1Meds!.length;
    } else if (grade.toLowerCase() == "grade 2") {
      return grade2Meds!.length;
    } else {
      return grade3Meds!.length;
    }
  }

  void editMedicineIntake(int index, String grade) {
    if (grade.toLowerCase() == "grade 1") {
      _updateFoodTime(grade1Meds![index]);
    } else if (grade.toLowerCase() == "grade 2") {
      _updateFoodTime(grade2Meds![index]);
    } else {
      _updateFoodTime(grade3Meds![index]);
    }
    notifyListeners();
  }

  void _updateFoodTime(MedicineDetailsModel data) {
    if (data.intakeDetails?.foodTime == "Before Food") {
      data.intakeDetails?.foodTime = "After Food";
    } else {
      data.intakeDetails?.foodTime = "Before Food";
    }
    notifyListeners();
  }

  void editMedicineType(int index, String grade, String medicineType) {
    if (grade.toLowerCase() == "grade 1") {
      _updateMedicineType(grade1Meds![index], medicineType);
    } else if (grade.toLowerCase() == "grade 2") {
      _updateMedicineType(grade2Meds![index], medicineType);
    } else {
      _updateMedicineType(grade3Meds![index], medicineType);
    }
    notifyListeners();
  }

  void _updateMedicineType(MedicineDetailsModel data, String medicineType) {
    data.medicineType = medicineType;
    notifyListeners();
  }

  void addIntakeDosage(String grade, int index, String intakeConstant) {
    if (grade.toLowerCase() == "grade 1") {
      _setIntake(grade1Meds![index], intakeConstant);
    } else if (grade.toLowerCase() == "grade 2") {
      _setIntake(grade2Meds![index], intakeConstant);
    } else {
      _setIntake(grade3Meds![index], intakeConstant);
    }
    notifyListeners();
  }

  void _setIntake(MedicineDetailsModel data, String intakeConstant) {
    if (data.intakeDetails!.intake.contains(intakeConstant)) {
      data.intakeDetails!.intake.remove(intakeConstant);
    } else {
      data.intakeDetails!.intake.add(intakeConstant);
    }
    notifyListeners();
  }

  void removeMedicineFromList({required String grade, required int index}) {
    if (grade.toLowerCase() == "grade 1") {
      grade1Meds!.removeAt(index);
      grade1NotesControllers.removeAt(index);
    } else if (grade.toLowerCase() == "grade 2") {
      grade2Meds!.removeAt(index);
      grade2NotesControllers.removeAt(index);
    } else {
      grade3Meds!.removeAt(index);
      grade3NotesControllers.removeAt(index);
    }
    notifyListeners();
  }

  void addGradeMedicine(String grade, MedicineDetailsModel medicine) {
    if (grade.toLowerCase() == "grade 1") {
      grade1Meds!.add(medicine);
      grade1NotesControllers.add(TextEditingController());
    } else if (grade.toLowerCase() == "grade 2") {
      grade2Meds!.add(medicine);
      grade2NotesControllers.add(TextEditingController());
    } else {
      grade3Meds!.add(medicine);
      grade3NotesControllers.add(TextEditingController());
    }
    notifyListeners();
  }

  List<MedicineDetailsModel> getGradeMedicines(String grade) {
    if (grade.toLowerCase() == "grade 1") {
      return grade1Meds!;
    } else if (grade.toLowerCase() == "grade 2") {
      return grade2Meds!;
    } else {
      return grade3Meds!;
    }
  }

  List<TextEditingController> getGradeController(String grade) {
    if (grade.toLowerCase() == "grade 1") {
      return grade1NotesControllers;
    } else if (grade.toLowerCase() == "grade 2") {
      return grade2NotesControllers;
    } else {
      return grade3NotesControllers;
    }
  }

  void addNewMedicine() {
    prescribedMedicines!.add(newMedicine);
    noteControllers.add(TextEditingController());
    notifyListeners();
  }

  void deleteMedicine(int index) {
    prescribedMedicines!.removeAt(index);
    noteControllers.removeAt(index);
    notifyListeners();
  }

  Future<List<Medicine>> getAllMedicine({int? page, String? searchKey}) async {
    try {
      GetMedicineParams params = GetMedicineParams(pageKey: page, searchKey: searchKey);
      return await getAllMedicineUseCase.execute(params);
    } catch (e) {
      rethrow;
    }
  }

  void generateGradeLevelControllers(int length) {
    noteControllers = List.generate(
      length,
      (index) => TextEditingController(),
    );
    notifyListeners();
  }

  Future<void> updateUser(User user) async {
    try {
      await updateUserUseCase.execute(user);
    } catch (e) {
      rethrow;
    }
  }
}
