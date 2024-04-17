import 'package:aasa_emr/features/user/data/models/clinic.dart';
import 'package:aasa_emr/features/user/data/models/settings_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class Analytics {
  static final _analytics = FirebaseAnalytics.instance;

  static Future<void> logSendOtp() async {
    return _analytics.logEvent(name: "send_otp");
  }

  static Future<void> logLogin() async {
    return _analytics.logLogin();
  }

  static Future<void> logLogout() async {
    return _analytics.logEvent(name: "logout");
  }

  static Future<void> chooseClinic({Clinic? clinic}) async {
    return _analytics.logEvent(name: "choose_clinic", parameters: {
      "clinic_id": clinic?.id,
      "clinic_name": clinic?.name,
    });
  }

  static Future<void> logStartNewRx() async {
    return _analytics.logEvent(name: "start_new_rx");
  }

  static Future<void> logStartRxNow() async {
    return _analytics.logEvent(name: "start_rx_now");
  }

  static Future<void> logStartFutureRx() async {
    return _analytics.logEvent(name: "start_future_rx");
  }

  static Future<void> logCreateDraftRx() async {
    return _analytics.logEvent(name: "create_draft_rx");
  }

  static Future<void> logPreviewAndSign() async {
    return _analytics.logEvent(name: "preview_and_sign");
  }

  static Future<void> logSendRxToPatient() async {
    return _analytics.logEvent(name: "send_rx_to_patient");
  }

  static Future<void> addNewCondition({String? conditionName}) async {
    return _analytics.logEvent(name: "add_condition", parameters: {
      "condition_name": conditionName,
    });
  }

  static Future<void> editCondition({Condition? condition}) async {
    return _analytics.logEvent(name: "edit_condition", parameters: {
      "condition_id": condition?.id ?? "",
      "condition_name": condition?.conditionName ?? "",
    });
  }

  static Future<void> editRxFormat() async {
    return _analytics.logEvent(name: "edit_rx_format");
  }

  static Future<void> editProfile() async {
    return _analytics.logEvent(name: "edit_profile");
  }

  static Future<void> editClinicAndReceptionist() async {
    return _analytics.logEvent(name: "edit_clinic_and_receptionist");
  }
}
