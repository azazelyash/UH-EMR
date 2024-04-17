import '../../../../common/provider/loading_provider.dart';
import 'package:flutter/material.dart';

class DashboardProvider extends LoadingProvider {
  DashboardProvider() {
    _pageController = PageController();
    _pageController.addListener(() {
      notifyListeners();
    });
  }


  // final List<String> _symptoms = [];
  // List<String> get symptoms => _symptoms;

  // void updateSymptom(String val) {
  //   if (symptoms.contains(val)) {
  //     symptoms.remove(val);
  //   } else {
  //     symptoms.add(val);
  //   }
  //   notifyListeners();
  // }

//   List<String?>? _selectedSymptoms = [];
//   List<String?>? get selectedSymptoms => _selectedSymptoms;

//   set selectedSymptoms(List<String?>? value) {
//     _selectedSymptoms = value;
//     notifyListeners();
//   }

//   void updatedSelectedSymptoms(String? value) {
//     int index = _selectedSymptoms!.indexWhere((element) => element == value);
//     if (index == -1) {
//       _selectedSymptoms!.add(value);
//     } else {
//       _selectedSymptoms!.removeAt(index);
//     }
//     notifyListeners();
//   }

//   final List<String> _symptoms = [];
//   List<String> get symptoms => _symptoms;

//   void updateSymptom(String val) {
//     if (symptoms.contains(val)) {
//       symptoms.remove(val);
//     } else {
//       symptoms.add(val);
//     }
//     notifyListeners();
//   }


  bool _createNewPatient = false;
  bool get createNewPatient => _createNewPatient;

  int? _selectedPendingTile;
  int? get selectedPendingTile => _selectedPendingTile;

  bool _startConsulationNow = false;
  bool get startConsulationNow => _startConsulationNow;

  bool _creatRxState = false;
  bool get creatRxState => _creatRxState;

  bool _fillDetailsState = false;
  bool get fillDetailsState => _fillDetailsState;

  int? _openedUpcomingAppointmentContainer;
  int? get openedUpcomingAppointmentContainer => _openedUpcomingAppointmentContainer;

  int? _openedPreviousAppointmentContainer;
  int? get openedPreviousAppointmentContainer => _openedPreviousAppointmentContainer;

  int? _selectedDatedAppointmentTile;
  int? get selectedDatedAppointmentTile => _selectedDatedAppointmentTile;

  List<String?>? _selectedSymptoms = [];
  List<String?>? get selectedSymptoms => _selectedSymptoms;

  set selectedSymptoms(List<String?>? value) {
    _selectedSymptoms = value;
    notifyListeners();
  }

  void updatedSelectedSymptoms(String? value) {
    int index = _selectedSymptoms!.indexWhere((element) => element == value);
    if (index == -1) {
      _selectedSymptoms!.add(value);
    } else {
      _selectedSymptoms!.removeAt(index);
    }
    notifyListeners();
  }

  set selectedDatedAppointmentTile(int? value) {
    _selectedDatedAppointmentTile = value;
    notifyListeners();
  }

  late PageController _pageController;
  PageController get pageController => _pageController;

  set openedUpcomingAppointmentContainer(int? value) {
    _openedUpcomingAppointmentContainer = value;
    notifyListeners();
  }

  set openedPreviousAppointmentContainer(int? value) {
    _openedPreviousAppointmentContainer = value;
    notifyListeners();
  }

  set selectedPendingTile(int? value) {
    _selectedPendingTile = value;
    notifyListeners();
  }

  set creatRxState(bool value) {
    _creatRxState = value;
    notifyListeners();
  }

  set fillDetailsState(bool value) {
    _fillDetailsState = value;
    notifyListeners();
  }

  set startConsulationNow(bool value) {
    _startConsulationNow = value;
    notifyListeners();
  }

  set createNewPatient(bool value) {
    _createNewPatient = value;
    notifyListeners();
  }

  void startConsulation() {
    if (startConsulationNow) {}
  }

  void newPatient() {
    createNewPatient = true;
  }

  void existingPatient() {
    createNewPatient = false;
  }

  void resestState() {
    createNewPatient = false;
    fillDetailsState = false;
    creatRxState = false;
    startConsulationNow = false;
    notifyListeners();
  }
}
