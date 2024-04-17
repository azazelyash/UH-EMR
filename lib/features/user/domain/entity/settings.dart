class Settings {
  final RxFormat? rxFormat;
  final List<RxTemplate> rxTemplates;

  Settings({this.rxFormat, this.rxTemplates = const []});

  Settings copyWith({
    RxFormat? rxFormat,
    List<RxTemplate>? rxTemplates,
  }) {
    return Settings(
      rxFormat: rxFormat ?? this.rxFormat,
      rxTemplates: rxTemplates ?? this.rxTemplates,
    );
  }
}

class RxFormat {
  PatientVitals? patientVitals;
  RxHeaderInfo? rxHeaderInfo;
  RxInfo? rxInfo;
  FooterInfo? footerInfo;

  RxFormat({this.patientVitals, this.rxHeaderInfo, this.rxInfo, this.footerInfo});

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
}

class PatientVitals {
  bool? bodyTemperature;
  bool? bloodPressure;
  bool? respirationRate;
  bool? pulseRate;
  bool? height;
  bool? weight;
  bool? age;

  PatientVitals({
    this.bodyTemperature,
    this.bloodPressure,
    this.respirationRate,
    this.pulseRate,
    this.height,
    this.weight,
    this.age,
  });

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
}

class RxHeaderInfo {
  bool? clinicAddress;
  bool? contactNo;
  bool? emailId;
  bool? logo;

  RxHeaderInfo({
    this.clinicAddress,
    this.contactNo,
    this.emailId,
    this.logo,
  });

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
}

class RxInfo {
  bool? symptoms;
  bool? diagnosis;
  bool? types;
  bool? medicines;

  RxInfo({
    this.symptoms,
    this.diagnosis,
    this.types,
    this.medicines,
  });

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
}

class FooterInfo {
  String? message;
  String? signatureColor;

  FooterInfo({this.message, this.signatureColor});

  FooterInfo copyWith({
    String? message,
    String? signatureColor,
  }) {
    return FooterInfo(
      message: message ?? this.message,
      signatureColor: signatureColor ?? this.signatureColor,
    );
  }
}

class RxTemplate {
  final String? id;
  final String? condition;
  final List<Medication> medication;

  RxTemplate({this.id, this.condition, this.medication = const []});

  RxTemplate copyWith({
    String? id,
    String? condition,
    List<Medication>? medication,
  }) {
    return RxTemplate(
      id: id ?? this.id,
      condition: condition ?? this.condition,
      medication: medication ?? this.medication,
    );
  }
}

class Medication {
  String? grade;
  List<MedicineDetails> medicineDetails;

  Medication({this.grade, this.medicineDetails = const []});

  Medication copyWith({
    String? grade,
    List<MedicineDetails>? medicineDetails,
  }) {
    return Medication(
      grade: grade ?? this.grade,
      medicineDetails: medicineDetails ?? this.medicineDetails,
    );
  }
}

class MedicineDetails {
  IntakeDetails? intakeDetails;
  String? medicineName;
  String? medicineType;
  String? message;

  MedicineDetails({this.intakeDetails, this.medicineName, this.medicineType, this.message});

  MedicineDetails copyWith({
    IntakeDetails? intakeDetails,
    String? medicineName,
    String? medicineType,
    String? message,
  }) {
    return MedicineDetails(
      intakeDetails: intakeDetails ?? this.intakeDetails,
      medicineName: medicineName ?? this.medicineName,
      medicineType: medicineType ?? this.medicineType,
      message: message ?? this.message,
    );
  }
}

class IntakeDetails {
  String? intake;
  String? days;
  String? amount;

  IntakeDetails({this.intake, this.days, this.amount});

  IntakeDetails copyWith({
    String? intake,
    String? days,
    String? amount,
  }) {
    return IntakeDetails(
      intake: intake ?? this.intake,
      days: days ?? this.days,
      amount: amount ?? this.amount,
    );
  }
}
