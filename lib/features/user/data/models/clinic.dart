import 'package:aasa_emr/features/user/data/models/user_model.dart';

class Clinic {
  String? id;
  List<Doctor> userDoctor;
  List<Receptionist> receptionists;
  String? address;
  String? logo;
  String? name;
  int? v;

  Clinic({
    this.id,
    this.userDoctor = const [],
    this.receptionists = const [],
    this.address,
    this.logo,
    this.name,
    this.v,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      id: json['_id'],
      userDoctor: json['userDoctor'] == null
          ? []
          : List.generate(json['userDoctor'].length, (index) => Doctor.fromJson(json['userDoctor'][index])),
      receptionists: json['receptionistID'] == null
          ? []
          : List.generate(json['userReceptionist'].length,
              (index) => Receptionist.fromJson(json['userReceptionist'][index]['profile'])),
      address: json['address'],
      logo: json['logo'],
      name: json['name'],
      v: json['__v'],
    );
  }

  Clinic copyWith({
    String? id,
    List<Doctor>? userDoctor,
    List<Receptionist>? receptionists,
    String? address,
    String? logo,
    String? name,
    int? v,
  }) {
    return Clinic(
      id: id ?? this.id,
      userDoctor: userDoctor ?? this.userDoctor,
      receptionists: receptionists ?? this.receptionists,
      address: address ?? this.address,
      logo: logo ?? this.logo,
      name: name ?? this.name,
      v: v ?? this.v,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctorID': userDoctor.first.docID,
      'userDoctor': userDoctor.map((doctor) => doctor.toJson()).toList(),
      // 'userReceptionist': receptionists.map((receptionist) => receptionist.toJson()).toList(),
      'address': address,
      'logo': logo,
      'name': name,
      '__v': v,
    };
  }
}

class Doctor {
  String? docID;
  String? name;

  Doctor({
    this.docID,
    this.name,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      docID: json['docID'],
      name: json['name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'docID': docID,
      'name': name,
    };
  }
}

class Receptionist {
  String? id;
  String? name;
  PhoneModel? phone;
  List<String>? doctorId;
  String? email;

  Receptionist({
    this.id,
    this.name,
    this.phone,
    this.doctorId,
    this.email,
  });

  Receptionist copyWith({
    String? id,
    String? name,
    PhoneModel? phone,
    List<String>? doctorId,
    String? email,
  }) {
    return Receptionist(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      doctorId: doctorId ?? this.doctorId,
      email: email ?? this.email,
    );
  }

  factory Receptionist.fromJson(Map<String, dynamic> json) {
    return Receptionist(
      id: json['_id'],
      name: json['profile']['name'],
      phone: json['profile']['phone'] != null ? PhoneModel.fromJson(json['profile']['phone']) : null,
      doctorId: json['profile']['doctorID'] != null
          ? List.generate(json['profile']['doctorID'], (index) => json['profile']['doctorID'][index])
          : [],
      email: json['profile']['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // '_id': id,
      // 'doctorId': doctorId,
      // 'phone': phone?.toJson(),
      // 'name': name,
      // 'email': email,
      "_id": id, // ObjectId
      "profile": {
        "name": name,
        "email": email,
        "phone": {"phoneNumber": phone?.phoneNumber, "countryCode": "+91"}
      },
      "listOfDoctors": doctorId
    };
  }
}
