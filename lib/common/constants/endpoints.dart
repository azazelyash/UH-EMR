class EndPoints {
  EndPoints._();
  static const String mrBaseUrl = "https://dev.be.aasa.ai/api/v1/aasa";
  static const String authBaseUrl = "https://dev.auth.aasa.ai/api/v1/auth";

  static const String signOut = "$authBaseUrl/signOut";
  static const String signInUrl = "$authBaseUrl/signIn";
  static const String sendOtpUrl = "$authBaseUrl/sendOtp";
  static const String getUserUrl = "$mrBaseUrl/common/getUser";
  static const String createRxUrl = "$mrBaseUrl/doctor/createRx";
  static const String uplaodImageUrl = "$mrBaseUrl/common/upload";
  static const String refreshTokenUrl = "$authBaseUrl/refreshToken";
  static const String getClinicsUrl = "$mrBaseUrl/common/getClinics";
  static const String signUpUrl = "$authBaseUrl/signUp";
  static const String deleteUserUrl = "$authBaseUrl/deleteUser";
  static const String checkIfUserExistsUrl = "$authBaseUrl/checkIfUserAlreadyExists";

  static const String updateUserUrl = "$mrBaseUrl/doctor/editSettings";

  static const String createClinicUrl = "$mrBaseUrl/doctor/createClinic";
  static const String updateClinicUrl = "$mrBaseUrl/doctor/updateClinic";
  static const String deleteClinicUrl = "$mrBaseUrl/doctor/deleteClinic";
  static const String getAllReceptionistsUrl = "$mrBaseUrl/doctor/getAllReceptionist";
  static const String createReceptionistUrl = "$mrBaseUrl/doctor/createReceptionist";
  static const String updateReceptionistUrl = "$mrBaseUrl/doctor/updateReceptionist";
  static const String deleteReceptionistUrl = "$mrBaseUrl/doctor/deleteReceptionist";

  static const String getAppointmentsUrl = "$mrBaseUrl/common/getAppointments";
  static const String updateAppointmentUrl = "$mrBaseUrl/common/editAppointment";
  static const String getPatientAppointmentsUrl = "$mrBaseUrl/common/getPatientAppointments";
  static const String getPatients = "$mrBaseUrl/doctor/getPatientList";
  static const String createPatient = "$mrBaseUrl/doctor/createPatient";
  static const String getAllMedicine = "$mrBaseUrl/doctor/getMedicines";
  static const String sendRxToPatient = "$mrBaseUrl/common/sendRxToPatient";
  static const String updatePatientUrl = "$mrBaseUrl/common/updatePatient";
  static const String getDateAppointment = "$mrBaseUrl/common/getDateAppointments";
  // static const String getAppointmentsUrl = "$mrBaseUrl/common/getAppointments";
  static const String createAppointment = "$mrBaseUrl/doctor/createAppointment";
  static const String getAppointmentRx = "$mrBaseUrl/common/getAppointmentRx";
  // static const String updateAppointmentUrl = "$mrBaseUrl/common/editAppointment";
  static const String getDropdownValues = "$mrBaseUrl/common/getDropdown";
}
