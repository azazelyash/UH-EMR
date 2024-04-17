import 'package:aasa_emr/common/constants/dummy_medicine_tile_data.dart';

class Settings {
  final RxFormat? rxFormat;
  final List<RxTemplate> rxTemplates;

  Settings({this.rxFormat, this.rxTemplates = const []});

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      rxFormat: RxFormat.fromJson(json['rxFormat']),
      rxTemplates: List<RxTemplate>.from(json['rxTemplates'].map((template) => RxTemplate.fromJson(template))),
    );
  }

  Settings copyWith({
    RxFormat? rxFormat,
    List<RxTemplate>? rxTemplates,
  }) {
    return Settings(
      rxFormat: rxFormat ?? this.rxFormat,
      rxTemplates: rxTemplates ?? this.rxTemplates,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rxFormat': rxFormat?.toJson(),
      'rxTemplates': rxTemplates.map((template) => template.toJson()).toList(),
    };
  }
}

class RxFormat {
  final PatientVitals? patientVitals;
  final RxHeaderInfo? rxHeaderInfo;
  final RxInfo? rxInfo;
  final FooterInfo? footerInfo;

  RxFormat({this.patientVitals, this.rxHeaderInfo, this.rxInfo, this.footerInfo});

  factory RxFormat.fromJson(Map<String, dynamic> json) {
    return RxFormat(
      patientVitals: PatientVitals.fromJson(json['patientVitals']),
      rxHeaderInfo: RxHeaderInfo.fromJson(json['rxHeaderInfo']),
      rxInfo: RxInfo.fromJson(json['rxInfo']),
      footerInfo: FooterInfo.fromJson(json['footerInfo']),
    );
  }

  RxFormat copyWith({
    PatientVitals? patientVitals,
    RxHeaderInfo? rxHeaderInfo,
    RxInfo? rxInfo,
    FooterInfo? footerInfo,
  }) {
    return RxFormat(
      patientVitals: patientVitals ?? this.patientVitals,
      rxHeaderInfo: rxHeaderInfo ?? this.rxHeaderInfo,
      rxInfo: rxInfo ?? this.rxInfo,
      footerInfo: footerInfo ?? this.footerInfo,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientVitals': patientVitals?.toJson(),
      'rxHeaderInfo': rxHeaderInfo?.toJson(),
      'rxInfo': rxInfo?.toJson(),
      'footerInfo': footerInfo?.toJson(),
    };
  }
}

class PatientVitals {
  final bool? bodyTemperature;
  final bool? bloodPressure;
  final bool? respirationRate;
  final bool? pulseRate;
  final bool? height;
  final bool? weight;
  final bool? age;

  PatientVitals({
    this.bodyTemperature,
    this.bloodPressure,
    this.respirationRate,
    this.pulseRate,
    this.height,
    this.weight,
    this.age,
  });

  factory PatientVitals.fromJson(Map<String, dynamic> json) {
    return PatientVitals(
      bodyTemperature: json['bodyTemperature'],
      bloodPressure: json['bloodPressure'],
      respirationRate: json['respirationRate'],
      pulseRate: json['pulseRate'],
      height: json['height'],
      weight: json['weight'],
      age: json['age'],
    );
  }

  PatientVitals copyWith({
    bool? bodyTemperature,
    bool? bloodPressure,
    bool? respirationRate,
    bool? pulseRate,
    bool? height,
    bool? weight,
    bool? age,
  }) {
    return PatientVitals(
      bodyTemperature: bodyTemperature ?? this.bodyTemperature,
      bloodPressure: bloodPressure ?? this.bloodPressure,
      respirationRate: respirationRate ?? this.respirationRate,
      pulseRate: pulseRate ?? this.pulseRate,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bodyTemperature': bodyTemperature,
      'bloodPressure': bloodPressure,
      'respirationRate': respirationRate,
      'pulseRate': pulseRate,
      'height': height,
      'weight': weight,
      'age': age,
    };
  }
}

class RxHeaderInfo {
  final bool? clinicAddress;
  final bool? contactNo;
  final bool? emailId;
  final bool? logo;

  RxHeaderInfo({
    this.clinicAddress,
    this.contactNo,
    this.emailId,
    this.logo,
  });

  factory RxHeaderInfo.fromJson(Map<String, dynamic> json) {
    return RxHeaderInfo(
      clinicAddress: json['clinicAddress'],
      contactNo: json['contactNo'],
      emailId: json['emailId'],
      logo: json['logo'],
    );
  }

  RxHeaderInfo copyWith({
    bool? clinicAddress,
    bool? contactNo,
    bool? emailId,
    bool? logo,
  }) {
    return RxHeaderInfo(
      clinicAddress: clinicAddress ?? this.clinicAddress,
      contactNo: contactNo ?? this.contactNo,
      emailId: emailId ?? this.emailId,
      logo: logo ?? this.logo,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clinicAddress': clinicAddress,
      'contactNo': contactNo,
      'emailId': emailId,
      'logo': logo,
    };
  }
}

class RxInfo {
  final bool? symptoms;
  final bool? diagnosis;
  final bool? types;
  final bool? medicines;

  RxInfo({
    this.symptoms,
    this.diagnosis,
    this.types,
    this.medicines,
  });

  factory RxInfo.fromJson(Map<String, dynamic> json) {
    return RxInfo(
      symptoms: json['symptoms'],
      diagnosis: json['diagnosis'],
      types: json['types'],
      medicines: json['medicines'],
    );
  }

  RxInfo copyWith({
    bool? symptoms,
    bool? diagnosis,
    bool? types,
    bool? medicines,
  }) {
    return RxInfo(
      symptoms: symptoms ?? this.symptoms,
      diagnosis: diagnosis ?? this.diagnosis,
      types: types ?? this.types,
      medicines: medicines ?? this.medicines,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symptoms': symptoms,
      'diagnosis': diagnosis,
      'types': types,
      'medicines': medicines,
    };
  }
}

class FooterInfo {
  final String? message;
  final String? signatureColor;

  FooterInfo({this.message, this.signatureColor});

  factory FooterInfo.fromJson(Map<String, dynamic> json) {
    return FooterInfo(
      message: json['message'],
      signatureColor: json['signatureColor'],
    );
  }

  FooterInfo copyWith({
    String? message,
    String? signatureColor,
  }) {
    return FooterInfo(
      message: message ?? this.message,
      signatureColor: signatureColor ?? this.signatureColor,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'signatureColor': signatureColor,
    };
  }
}

class RxTemplate {
  final String? id;

  final Condition? condition;
  final List<MedicationModel> medication;

  RxTemplate({this.id, this.condition, this.medication = const []});

  factory RxTemplate.fromJson(Map<String, dynamic> json) {
    return RxTemplate(
      id: json['_id'],
      condition: json['condition'] != null ? Condition.fromJson(json['condition']) : null,
      medication: List<MedicationModel>.from(json['medication'].map((med) => MedicationModel.fromJson(med))),
    );
  }

  RxTemplate copyWith({
    String? id,
    Condition? condition,
    List<MedicationModel>? medication,
  }) {
    return RxTemplate(
      condition: condition ?? this.condition,
      medication: medication ?? this.medication,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'condition': condition!.toJson(),
      'medication': medication.map((med) => med.toJson()).toList(),
    };
  }
}

class Condition {
  final String? id;
  final String? conditionName;

  Condition({this.id, this.conditionName});

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      id: json['id'],
      conditionName: json['conditionName'],
    );
  }

  Condition copyWith({
    String? id,
    String? conditionName,
  }) {
    return Condition(
      id: id ?? this.id,
      conditionName: conditionName ?? this.conditionName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conditionName': conditionName,
    };
  }
}

class MedicationModel {
  final String? id;
  final String? grade;
  final List<MedicineDetailsModel> medicineDetails;

  MedicationModel({this.id, this.grade, this.medicineDetails = const []});

  factory MedicationModel.fromJson(Map<String, dynamic> json) {
    return MedicationModel(
      id: json['id'],
      grade: json['grade'],
      medicineDetails: List<MedicineDetailsModel>.from(json['medicineDetails'].map((details) => MedicineDetailsModel.fromJson(details))),
    );
  }

  MedicationModel copyWith({
    String? id,
    String? grade,
    List<MedicineDetailsModel>? medicineDetails,
  }) {
    return MedicationModel(
      id: id ?? this.id,
      grade: grade ?? this.grade,
      medicineDetails: medicineDetails ?? this.medicineDetails,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'grade': grade,
      'medicineDetails': medicineDetails.map((details) => details.toJson()).toList(),
    };
  }
}

class MedicineDetailsModel {
  String? id;
  IntakeDetailsModel? intakeDetails;
  String? medicineName;
  String? medicineType;
  String? message;

  MedicineDetailsModel({
    this.id,
    this.intakeDetails,
    this.medicineName,
    this.medicineType,
    this.message,
  });

  factory MedicineDetailsModel.fromJson(Map<String, dynamic> json) {
    return MedicineDetailsModel(
      id: json['id'],
      intakeDetails: IntakeDetailsModel.fromJson(json['intakeDetails']),
      medicineName: json['medicineName'],
      medicineType: json['medicineType'],
      message: json['message'],
    );
  }

  MedicineDetailsModel copyWith({
    String? id,
    IntakeDetailsModel? intakeDetails,
    String? medicineName,
    String? medicineType,
    String? message,
  }) {
    return MedicineDetailsModel(
      id: id ?? this.id,
      intakeDetails: intakeDetails ?? this.intakeDetails,
      medicineName: medicineName ?? this.medicineName,
      medicineType: medicineType ?? this.medicineType,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'intakeDetails': intakeDetails?.toJson(),
      'medicineName': medicineName,
      'medicineType': medicineType,
      'message': message,
    };
  }
}

class IntakeDetailsModel {
  List<String> intake;
  String? foodTime;
  String? days;
  String? amount;

  IntakeDetailsModel({
    this.foodTime = "Before Food",
    this.intake = const [],
    this.days,
    this.amount,
  });

  factory IntakeDetailsModel.fromJson(Map<String, dynamic> json) {
    return IntakeDetailsModel(
      intake: json['intake'] != null ? List<String>.from(json['intake']) : [],
      days: json['days'] ?? noOfDays[0],
      amount: json['amount'] ?? frequency[0],
      foodTime: json['foodTime'] ?? "Before Food",
    );
  }

  IntakeDetailsModel copyWith({
    List<String>? intake,
    String? days,
    String? amount,
    String? foodTime,
  }) {
    return IntakeDetailsModel(
      intake: intake ?? this.intake,
      days: days ?? this.days,
      amount: amount ?? this.amount,
      foodTime: foodTime ?? this.foodTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'intake': intake,
      'days': days,
      'amount': amount,
      'foodTime': foodTime,
    };
  }
}
