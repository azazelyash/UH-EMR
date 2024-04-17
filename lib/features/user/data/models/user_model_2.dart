// import 'package:aasa_emr/features/user/data/models/settings_model.dart';
// import 'package:aasa_emr/features/user/domain/entity/user.dart';

// class UserModel extends User {
//   UserModel({final ProfileModel? profile, final SettingsModel? settings, final String? id})
//       : super(profile: profile, settings: settings, id: id);

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       profile: json['profile'] != null ? ProfileModel.fromJson(json['profile']) : null,
//       settings: json['settings'] != null ? SettingsModel.fromJson(json['settings']) : null,
//       id: json['_id'],
//     );
//   }
// }

// class ProfileModel extends Profile {
//   ProfileModel(
//       {final String? name,
//       final PhoneModel? phone,
//       final String? email,
//       final String? specialization,
//       final String? mrn,
//       final String? medicalId,
//       final String? dob,
//       final String? council,
//       final List<DegreeModel> degrees = const [],
//       final List<String> clinics = const [],
//       final String? docPhoto,
//       final String? docSign})
//       : super(
//           name: name,
//           phone: phone,
//           email: email,
//           specialization: specialization,
//           mrn: mrn,
//           medicalId: medicalId,
//           dob: dob != null ? DateTime.parse(dob) : null,
//           council: council,
//           degrees: degrees,
//           clinics: clinics,
//           docPhoto: docPhoto,
//           docSign: docSign,
//         );

//   factory ProfileModel.fromJson(Map<String, dynamic> json) {
//     return ProfileModel(
//       name: json['name'],
//       phone: json['phone'] != null ? PhoneModel.fromJson(json['phone']) : null,
//       email: json['email'],
//       specialization: json['Specialization'],
//       mrn: json['MRN'],
//       medicalId: json['MedicalId'],
//       dob: json['DOB'],
//       council: json['Council'],
//       degrees: json['degrees'] != null
//           ? List<DegreeModel>.from(json['degrees'].map((degree) => DegreeModel.fromJson(degree)))
//           : [],
//       clinics: json['clinics'] != null ? List<String>.from(json['clinics']) : [],
//       docPhoto: json['docPhoto'],
//       docSign: json['docSign'],
//     );
//   }
// }

// class PhoneModel extends Phone {
//   PhoneModel({final String? phoneNumber, final String? countryCode})
//       : super(phoneNumber: phoneNumber, countryCode: countryCode);

//   factory PhoneModel.fromJson(Map<String, dynamic> json) {
//     return PhoneModel(
//       phoneNumber: json['phoneNumber'],
//       countryCode: json['countryCode'],
//     );
//   }
// }

// class DegreeModel extends Degree {
//   DegreeModel({final String? degreeName, final String? collegeName, final String? passingYear})
//       : super(degreeName: degreeName, collegeName: collegeName, passingYear: passingYear);

//   factory DegreeModel.fromJson(Map<String, dynamic> json) {
//     return DegreeModel(
//       degreeName: json['degreeName'],
//       collegeName: json['collegeName'],
//       passingYear: json['passingYear'],
//     );
//   }
// }
