import '../../features/dashboard/data/models/patients.dart';

class PhoneNumberParser {
  PhoneNumberParser._();

  static String getPhoneString(Phone phone) {
    String? countryCode = phone.countryCode;
    String? phoneNumber = phone.phoneNumber;

    if (countryCode == null && phoneNumber == null) {
      return "";
    } else if (countryCode == null) {
      return phoneNumber!;
    } else {
      return "${phone.countryCode} ${phone.phoneNumber}";
    }
  }
}
