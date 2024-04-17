import '../../../user/data/models/user_model.dart';
import 'package:flutter/foundation.dart';

class PatientVitalsProvider extends ChangeNotifier {
  final User user;
  final List<String> allPatientVitals = [
    'Height',
    'Weight',
    'Age',
    'Body Temperature',
    'Blood Pressure',
    'Respiration Rate',
    'Pulse Rate',
  ];

  final List<String> selectedVitals = [];

  late String selectedVital;

  PatientVitalsProvider({required this.user});

  void initializeVitals() {
    if (user.settings?.rxFormat?.patientVitals != null) {
      final vitals = user.settings?.rxFormat?.patientVitals;

      if (vitals?.height ?? false) {
        selectedVitals.add('Height');
      }
      if (vitals?.weight ?? false) {
        selectedVitals.add('Weight');
      }
      if (vitals?.age ?? false) {
        selectedVitals.add('Age');
      }
      if (vitals?.bodyTemperature ?? false) {
        selectedVitals.add('Body Temperature');
      }
      if (vitals?.bloodPressure ?? false) {
        selectedVitals.add('Blood Pressure');
      }
      if (vitals?.respirationRate ?? false) {
        selectedVitals.add('Respiration Rate');
      }
      if (vitals?.pulseRate ?? false) {
        selectedVitals.add('Pulse Rate');
      }
    }
  }

  void onChanged(bool? value, String vitalName) {
    if (value!) {
      selectedVitals.add(vitalName);
    } else {
      selectedVitals.remove(vitalName);
    }
    notifyListeners();
  }
}
