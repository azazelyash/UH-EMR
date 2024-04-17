// {
//   "doctorId": "5fc2b15b86a614001f43e625",
//   "patientId": "5fc2b15b86a614001f43e626",
//   "patientBasicDetail": {
//     "name": "Kumar",
//     "visit": "Checkup",
//     "age": "35",
//     "height": "175 cm",
//     "weight": "70 kg"
//   },
//   "diagnosis": [
//     {
//       "condition": {
//         "id": "5fc2b15b86a614001f43e627",
//         "conditionName": "Hypertension"
//       },
//       "grade": {
//         "id": "5fc2b15b86a614001f43e628",
//         "gradeName": "Mild"
//       }
//     },
//     {
//       "condition": {
//         "id": "5fc2b15b86a614001f43e629",
//         "conditionName": "Diabetes"
//       },
//       "grade": {
//         "id": "5fc2b15b86a614001f43e62a",
//         "gradeName": "Moderate"
//       }
//     }
//   ],
//   "medication": [
//     {
//       "id": "5fc2b15b86a614001f43e62b",
//       "medicine": "Metformin",
//       "days": "30",
//       "foodTime": "After meals",
//       "frequency": "Once daily",
//       "note": "Take with plenty of water"
//     },
//     {
//       "id": "5fc2b15b86a614001f43e62c",
//       "medicine": "Lisinopril",
//       "days": "30",
//       "foodTime": "Before meals",
//       "frequency": "Twice daily",
//       "note": "Avoid alcohol consumption"
//     }
//   ],
//   "test": [
//     {
//       "id": "5fc2b15b86a614001f43e62d",
//       "testName": "Blood Glucose Test",
//       "note": "Fasting required"
//     },
//     {
//       "id": "5fc2b15b86a614001f43e62e",
//       "testName": "Blood Pressure Measurement",
//       "note": "Rest for 5 minutes before the test"
//     }
//   ],
//   "additionalNotes": "Patient shows signs of improvement. Follow up after 3 months.",
//   "nextVisit": "2024-06-20T00:00:00.000Z"
// }

class RxModel {
  String? doctorId;
  String? patientId;
  String? appointmentId;
  PatientBasicDetail? patientBasicDetail;
  List<Diagnosis>? diagnosis;
  List<Medication>? medication;
  List<Test>? test;
  String? additionalNotes;
  DateTime? nextVisit;
  List<String?>? symptoms;

  RxModel({
    this.doctorId,
    this.patientId,
    this.appointmentId,
    this.patientBasicDetail,
    this.diagnosis,
    this.medication,
    this.test,
    this.additionalNotes,
    this.nextVisit,
    this.symptoms,
  });

  factory RxModel.fromJson(Map<String, dynamic> json) {
    return RxModel(
      doctorId: json['doctorId'],
      patientId: json['patientId'],
      appointmentId: json['appointmentId'],
      patientBasicDetail: json['patientBasicDetail'] != null ? PatientBasicDetail.fromJson(json['patientBasicDetail']) : null,
      diagnosis: json['diagnosis'] != null ? (json['diagnosis'] as List).map((e) => Diagnosis.fromJson(e)).toList() : null,
      medication: json['medication'] != null ? (json['medication'] as List).map((e) => Medication.fromJson(e)).toList() : null,
      test: json['test'] != null ? (json['test'] as List).map((e) => Test.fromJson(e)).toList() : null,
      additionalNotes: json['additionalNotes'],
      symptoms: json['symptoms'] != null ? List<String>.from(json['symptoms']) : [],
      nextVisit: json['nextVisit'] != null ? DateTime.parse(json['nextVisit']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctorId': doctorId,
      'patientId': patientId,
      'appointmentId': appointmentId,
      'patientBasicDetail': patientBasicDetail?.toJson(),
      'diagnosis': diagnosis?.map((e) => e.toJson()).toList(),
      'medication': medication?.map((e) => e.toJson()).toList(),
      'test': test?.map((e) => e.toJson()).toList(),
      'additionalNotes': additionalNotes,
      'symptoms': symptoms,
      'nextVisit': nextVisit?.toIso8601String(),
    };
  }
}

class PatientBasicDetail {
  String? name;
  String? visit;
  String? phone;
  String? email;
  String? age;
  String? height;
  String? weight;
  String? pulseRate;
  String? bloodPressure;
  String? bodyTemperature;
  String? respirationRate;

  PatientBasicDetail({
    this.name,
    this.visit,
    this.email,
    this.phone,
    this.age,
    this.height,
    this.weight,
    this.pulseRate,
    this.bloodPressure,
    this.bodyTemperature,
    this.respirationRate,
  });

  factory PatientBasicDetail.fromJson(Map<String, dynamic> json) {
    return PatientBasicDetail(
      name: json['name'],
      visit: json['visit'],
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
      'name': name,
      'visit': visit,
      'age': age,
      'height': height,
      'weight': weight,
      'pulseRate': pulseRate,
      'bloodPressure': bloodPressure,
      'respirationRate': respirationRate,
      'bodyTemperature': bodyTemperature,
    };
  }
}

class Diagnosis {
  Condition? condition;
  Grade? grade;

  Diagnosis({
    this.condition,
    this.grade,
  });

  factory Diagnosis.fromJson(Map<String, dynamic> json) {
    return Diagnosis(
      condition: json['condition'] != null ? Condition.fromJson(json['condition']) : null,
      grade: json['grade'] != null ? Grade.fromJson(json['grade']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'condition': condition?.toJson(),
      'grade': grade?.toJson(),
    };
  }
}

class Condition {
  String? id;
  String? conditionName;

  Condition({
    this.id,
    this.conditionName,
  });

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      id: json['id'],
      conditionName: json['conditionName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conditionName': conditionName,
    };
  }
}

class Grade {
  String? id;
  String? gradeName;

  Grade({
    this.id,
    this.gradeName,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id'],
      gradeName: json['gradeName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gradeName': gradeName,
    };
  }
}

class Medication {
  String? id;
  List<String>? intake;
  String? medicine;
  String? medicineType;
  String? days;
  String? foodTime;
  String? frequency;
  String? note;

  Medication({
    this.id,
    this.intake,
    this.medicine,
    this.medicineType,
    this.days,
    this.foodTime,
    this.frequency,
    this.note,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'],
      intake: json['intake'] != null ? List<String>.from(json['intake']) : null,
      medicine: json['medicine'],
      medicineType: json['medicineType'],
      days: json['days'],
      foodTime: json['foodTime'],
      frequency: json['frequency'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medicine': medicine,
      'medicineType': medicineType,
      'days': days,
      'intake': intake,
      'foodTime': foodTime,
      'frequency': frequency,
      'note': note,
    };
  }
}

class Test {
  String? id;
  String? testName;
  String? note;

  Test({
    this.id,
    this.testName,
    this.note,
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['id'],
      testName: json['testName'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'testName': testName,
      'note': note,
    };
  }
}
