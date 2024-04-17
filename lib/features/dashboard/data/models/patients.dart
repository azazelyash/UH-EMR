// {
//     "name": "Ramesh",
//     "email": "rmsh@gmail.com",
//     "phone": {
//         "phoneNumber": "9876123450",
//         "countryCode": "+91"
//     },
//     "dob": "2001-02-12T00:00:00.000Z",
//     "symptoms": [],
//     "address": "123 Main Street, Cityville, USA",
//     "doctorIDs": [
//         "65cb717b8be7cae48cad055e"
//     ],
//     "_id": "65f411787ab92f9d2470826a",
//     "patientVitals": [],
//     "__v": 0
// }

class Patient {
  String? id;
  String? name;
  String? email;
  Phone? phone;
  DateTime? dob;
  PatientVital? patientVitals;
  List<String>? symptoms;
  String? address;
  List<String>? doctorIDs;
  int? v;

  Patient({
    this.phone,
    this.id,
    this.name,
    this.email,
    this.dob,
    this.patientVitals,
    this.symptoms,
    this.address,
    this.doctorIDs,
    this.v,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      phone: json['phone'] != null ? Phone.fromJson(json['phone']) : null,
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
      patientVitals: PatientVital.fromJson(json['patientVitals']),
      symptoms: json['symptoms'] != null ? List<String>.from(json['symptoms']) : null,
      address: json['address'],
      doctorIDs: json['doctorIDs'] != null ? List<String>.from(json['doctorIDs']) : null,
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone?.toJson(),
      'name': name,
      'email': email,
      'dob': dob?.toIso8601String(),
      'patientVitals': (patientVitals != null) ? patientVitals!.toJson() : null,
      'symptoms': symptoms,
      'address': address,
      'doctorIDs': doctorIDs,
    };
  }

  Patient copyWith({
    Phone? phone,
    String? id,
    String? name,
    String? email,
    DateTime? dob,
    PatientVital? patientVitals,
    List<String>? symptoms,
    String? address,
    List<String>? doctorIDs,
    int? v,
  }) {
    return Patient(
      phone: phone ?? this.phone,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      patientVitals: patientVitals ?? this.patientVitals,
      symptoms: symptoms ?? this.symptoms,
      address: address ?? this.address,
      doctorIDs: doctorIDs ?? this.doctorIDs,
      v: v ?? this.v,
    );
  }
}

class Phone {
  String? phoneNumber;
  String? countryCode;

  Phone({
    this.phoneNumber,
    this.countryCode,
  });

  factory Phone.fromJson(Map<String, dynamic> json) {
    return Phone(
      phoneNumber: json['phoneNumber'],
      countryCode: json['countryCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'countryCode': countryCode,
    };
  }

  Phone copyWith({
    String? phoneNumber,
    String? countryCode,
  }) {
    return Phone(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
    );
  }
}

class PatientVital {
  String? age;
  String? height;
  String? weight;
  String? pulseRate;
  String? bloodPressure;
  String? bodyTemperature;
  String? respirationRate;

  PatientVital({
    this.age,
    this.height,
    this.weight,
    this.pulseRate,
    this.bloodPressure,
    this.bodyTemperature,
    this.respirationRate,
  });

  factory PatientVital.fromJson(Map<String, dynamic> json) {
    return PatientVital(
      age: json['age'],
      height: json['height'],
      weight: json['weight'],
      pulseRate: json['pulseRate'],
      bloodPressure: json['bloodPressure'],
      bodyTemperature: json['bodyTemperature'],
      respirationRate: json['respirationRate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'height': height,
      'weight': weight,
      'pulseRate': pulseRate,
      'bloodPressure': bloodPressure,
      'respirationRate': respirationRate,
      'bodyTemperature': bodyTemperature,
    };
  }

  PatientVital copyWith({
    String? age,
    String? height,
    String? weight,
    String? pulseRate,
    String? bloodPressure,
    String? bodyTemperature,
    String? respirationRate,
  }) {
    return PatientVital(
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      pulseRate: pulseRate ?? this.pulseRate,
      bloodPressure: bloodPressure ?? this.bloodPressure,
      bodyTemperature: bodyTemperature ?? this.bodyTemperature,
      respirationRate: respirationRate ?? this.respirationRate,
    );
  }
}
