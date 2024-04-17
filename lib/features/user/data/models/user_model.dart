import 'clinic.dart';
import 'settings_model.dart';

class User {
  final Profile? profile;
  final Settings? settings;
  final List<User>? listOfDoctors;
  final Role? role;
  final String? id;

  User({this.profile, this.settings, this.id, this.listOfDoctors, this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      profile: json['profile'] != null ? Profile.fromJson(json['profile']) : null,
      settings: json['settings'] != null ? Settings.fromJson(json['settings']) : null,
      listOfDoctors: json['listOfDoctors'] != null ? List<User>.from(json['listOfDoctors'].map((user) => User.fromJson(user))) : [],
      role: json['role'] != null ? Role.fromJson(json['role']) : null,
      id: json['_id'],
    );
  }

  User copyWith({
    Profile? profile,
    Settings? settings,
    List<User>? listOfDoctors,
    Role? role,
    String? id,
  }) {
    return User(
      profile: profile ?? this.profile,
      settings: settings ?? this.settings,
      listOfDoctors: listOfDoctors ?? this.listOfDoctors,
      role: role ?? this.role,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile': profile?.toJson(),
      'settings': settings?.toJson(),
      'listOfDoctors': (listOfDoctors != null) ? listOfDoctors!.map((element) => element.toJson()).toList() : null,
      'role': role?.toJson(),
      '_id': id,
    };
  }
}

class Profile {
  final String? mrn;
  final String? name;
  final String? email;
  final DateTime? dob;
  final String? council;
  final String? address;
  final String? docSign;
  final String? docPhoto;
  final PhoneModel? phone;
  final String? medicalId;
  final List<String> clinics;
  final String? specialization;
  final List<DegreeModel> degrees;
  final List<Receptionist> receptionists;

  Profile({
    this.name,
    this.phone,
    this.address,
    this.email,
    this.specialization,
    this.mrn,
    this.medicalId,
    this.dob,
    this.council,
    this.degrees = const [],
    this.clinics = const [],
    this.receptionists = const [],
    this.docPhoto,
    this.docSign,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      phone: json['phone'] != null ? PhoneModel.fromJson(json['phone']) : null,
      email: json['email'],
      address: json['address'],
      specialization: json['Specialization'],
      mrn: json['MRN'],
      medicalId: json['MedicalId'],
      dob: json['DOB'] != null ? DateTime.parse(json['DOB']) : null,
      council: json['Council'],
      degrees: json['degrees'] != null
          ? List<DegreeModel>.from(json['degrees'].map((degree) => DegreeModel.fromJson(degree)))
          : [],
      receptionists: json['userReceptionist'] != null
          ? List.generate(
              json['userReceptionist'].length,
              (index) => Receptionist.fromJson(json['userReceptionist'][index]),
            )
          : [],
      clinics: json['clinics'] != null ? List<String>.from(json['clinics']) : [],
      docPhoto: json['docPhoto'],
      docSign: json['docSign'],
    );
  }

  Profile copyWith({
    String? name,
    PhoneModel? phone,
    String? email,
    String? specialization,
    String? mrn,
    String? address,
    String? medicalId,
    DateTime? dob,
    String? council,
    List<DegreeModel>? degrees,
    List<String>? clinics,
    String? docPhoto,
    String? docSign,
  }) {
    return Profile(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      specialization: specialization ?? this.specialization,
      mrn: mrn ?? this.mrn,
      address: address ?? this.address,
      medicalId: medicalId ?? this.medicalId,
      dob: dob ?? this.dob,
      council: council ?? this.council,
      degrees: degrees ?? this.degrees,
      clinics: clinics ?? this.clinics,
      docPhoto: docPhoto ?? this.docPhoto,
      docSign: docSign ?? this.docSign,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone?.toJson(),
      'email': email,
      'address': address,
      'Specialization': specialization,
      'MRN': mrn,
      'MedicalId': medicalId,
      'DOB': dob?.toIso8601String(),
      'Council': council,
      'degrees': degrees.map((degree) => degree.toJson()).toList(),
      'clinics': clinics,
      'docPhoto': docPhoto,
      'docSign': docSign,
    };
  }
}

class PhoneModel {
  final String? phoneNumber;
  final String? countryCode;

  PhoneModel({this.phoneNumber, this.countryCode});

  factory PhoneModel.fromJson(Map<String, dynamic> json) {
    return PhoneModel(
      phoneNumber: json['phoneNumber'],
      countryCode: json['countryCode'],
    );
  }

  PhoneModel copyWith({
    String? phoneNumber,
    String? countryCode,
  }) {
    return PhoneModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'countryCode': countryCode,
    };
  }
}

class DegreeModel {
  final String? degreeName;
  final String? collegeName;
  final String? passingYear;

  DegreeModel({this.degreeName, this.collegeName, this.passingYear});

  factory DegreeModel.fromJson(Map<String, dynamic> json) {
    return DegreeModel(
      degreeName: json['degreeName'],
      collegeName: json['collegeName'],
      passingYear: json['passingYear'],
    );
  }

  DegreeModel copyWith({
    String? degreeName,
    String? collegeName,
    String? passingYear,
  }) {
    return DegreeModel(
      degreeName: degreeName ?? this.degreeName,
      collegeName: collegeName ?? this.collegeName,
      passingYear: passingYear ?? this.passingYear,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'degreeName': degreeName,
      'collegeName': collegeName,
      'passingYear': passingYear,
    };
  }
}

class ModuleValues {
  ModuleValues._();

  static const String appointments = "appointments";
  static const String medicalRecords = "medical_records";
}

class RoleNames {
  RoleNames._();

  static const String doctor = "doctor";
  static const String receptionist = "receptionist";
}

class Role {
  final String? roleName;
  final List<String>? moduleAccess;

  Role({
    required this.roleName,
    required this.moduleAccess,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      roleName: json['roleName'],
      moduleAccess: json['moduleAccess'] != null ? List<String>.from(json['moduleAccess']) : [],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'roleName': roleName,
      'moduleAccess': moduleAccess,
    };
  }

  Role copyWith({
    String? roleName,
    List<String>? moduleAccess,
  }) {
    return Role(
      roleName: roleName ?? this.roleName,
      moduleAccess: moduleAccess ?? this.moduleAccess,
    );
  }
}
