import 'package:flutter/foundation.dart';

import '../../../user/data/models/user_model.dart';

class HeaderInfoProvider extends ChangeNotifier {
  final User user;
  final List<String> allHeaderInfo = [
    'Clinic Address',
    'Contact No.',
    'Logo',
    'Email Id',
  ];

  final List<String> selectedHeaderInfo = [];

  HeaderInfoProvider({required this.user});

  void initializeHeaderInfo() {
    if (user.settings?.rxFormat?.rxHeaderInfo != null) {
      final vitals = user.settings?.rxFormat?.rxHeaderInfo;

      if (vitals?.clinicAddress ?? false) {
        selectedHeaderInfo.add('Clinic Address');
      }
      if (vitals?.contactNo ?? false) {
        selectedHeaderInfo.add('Contact No.');
      }
      if (vitals?.logo ?? false) {
        selectedHeaderInfo.add('Logo');
      }
      if (vitals?.emailId ?? false) {
        selectedHeaderInfo.add('Email Id');
      }
    }
  }

  void onChanged(bool? value, String vitalName) {
    if (value!) {
      selectedHeaderInfo.add(vitalName);
    } else {
      selectedHeaderInfo.remove(vitalName);
    }
    notifyListeners();
  }
}
