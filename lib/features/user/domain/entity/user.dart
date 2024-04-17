// import 'package:aasa_emr/features/user/domain/entity/settings.dart';

// class User {
//   Profile? profile;
//   Settings? settings;
//   String? id;

//   User({this.profile, this.settings, this.id});

//   User copyWith({
//     Profile? profile,
//     Settings? settings,
//     String? id,
//   }) {
//     return User(
//       profile: profile ?? this.profile,
//       settings: settings ?? this.settings,
//       id: id ?? this.id,
//     );
//   }
// }

// class Profile {
//   String? name;
//   Phone? phone;
//   String? email;
//   String? specialization;
//   String? mrn;
//   String? medicalId;
//   DateTime? dob;
//   String? council;
//   List<Degree> degrees;
//   List<String>? clinics;
//   String? docPhoto;
//   String? docSign;

//   Profile({
//     this.name,
//     this.phone,
//     this.email,
//     this.specialization,
//     this.mrn,
//     this.medicalId,
//     this.dob,
//     this.council,
//     this.degrees = const [],
//     this.clinics,
//     this.docPhoto,
//     this.docSign,
//   });

//   Profile copyWith({
//     String? name,
//     Phone? phone,
//     String? email,
//     String? specialization,
//     String? mrn,
//     String? medicalId,
//     DateTime? dob,
//     String? council,
//     List<Degree>? degrees,
//     List<String>? clinics,
//     String? docPhoto,
//     String? docSign,
//   }) {
//     return Profile(
//       name: name ?? this.name,
//       phone: phone ?? this.phone,
//       email: email ?? this.email,
//       specialization: specialization ?? this.specialization,
//       mrn: mrn ?? this.mrn,
//       medicalId: medicalId ?? this.medicalId,
//       dob: dob ?? this.dob,
//       council: council ?? this.council,
//       degrees: degrees ?? this.degrees,
//       clinics: clinics ?? this.clinics,
//       docPhoto: docPhoto ?? this.docPhoto,
//       docSign: docSign ?? this.docSign,
//     );
//   }
// }

// class Phone {
//   String? phoneNumber;
//   String? countryCode;

//   Phone({this.phoneNumber, this.countryCode});

//   Phone copyWith({
//     String? phoneNumber,
//     String? countryCode,
//   }) {
//     return Phone(
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       countryCode: countryCode ?? this.countryCode,
//     );
//   }
// }

// class Degree {
//   String? degreeName;
//   String? collegeName;
//   String? passingYear;

//   Degree({this.degreeName, this.collegeName, this.passingYear});

//   Degree copyWith({
//     String? degreeName,
//     String? collegeName,
//     String? passingYear,
//   }) {
//     return Degree(
//       degreeName: degreeName ?? this.degreeName,
//       collegeName: collegeName ?? this.collegeName,
//       passingYear: passingYear ?? this.passingYear,
//     );
//   }
// }
