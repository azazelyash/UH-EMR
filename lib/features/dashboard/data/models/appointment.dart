import 'patients.dart';

class AppointmentStatusValues {
  AppointmentStatusValues._();

  static const String done = "done";
  static const String pending = "pending";
  static const String cancelled = "cancelled";
}

class Appointment {
  int? v;
  String? id;
  bool? isSold;
  String? visit;
  Status? status;
  String? clinic;
  DateTime? dateTime;
  Patient? userPatient;
  DoctorModel? userDoctor;
  List<Message>? messages;

  Appointment({
    this.status,
    this.id,
    this.userDoctor,
    this.userPatient,
    this.dateTime,
    this.clinic,
    this.messages,
    this.isSold,
    this.visit,
    this.v,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      status: json['status'] != null ? Status.fromJson(json['status']) : null,
      id: json['_id'],
      userDoctor: json['userDoctor'] != null ? DoctorModel.fromJson(json['userDoctor']) : null,
      userPatient: json['userPatient'] != null ? Patient.fromJson(json['userPatient']) : null,
      dateTime: json['dateTime'] != null ? DateTime.parse(json['dateTime']) : null,
      clinic: json['clinic'],
      messages: json['messages'] != null ? List<Message>.from(json['messages'].map((x) => Message.fromJson(x))) : null,
      isSold: json['isSold'],
      visit: json['visit'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status?.toJson(),
      'id': id,
      'userDoctor': userDoctor?.toJson(),
      'userPatient': userPatient?.toJson(),
      'dateTime': dateTime?.toIso8601String(),
      'clinic': clinic,
      'visit': visit,
      'messages': messages?.map((x) => x.toJson()).toList(),
      'isSold': isSold,
      '__v': v,
    };
  }

  Map<String, dynamic> toJsonWithPatientId() {
    return {
      'status': status?.toJson(),
      'id': id,
      'userDoctor': userDoctor,
      'userPatient': userPatient!.id,
      'dateTime': dateTime?.toIso8601String(),
      'clinic': clinic,
      'visit': visit,
      'messages': messages?.map((x) => x.toJson()).toList(),
      'isSold': isSold,
      '__v': v,
    };
  }

  Appointment copyWith({
    Status? status,
    String? id,
    DoctorModel? userDoctor,
    Patient? userPatient,
    DateTime? dateTime,
    String? clinic,
    List<Message>? messages,
    bool? isSold,
    String? visit,
    int? v,
  }) {
    return Appointment(
      status: status ?? this.status,
      id: id ?? this.id,
      userDoctor: userDoctor ?? this.userDoctor,
      userPatient: userPatient ?? this.userPatient,
      dateTime: dateTime ?? this.dateTime,
      clinic: clinic ?? this.clinic,
      messages: messages ?? this.messages,
      isSold: isSold ?? this.isSold,
      visit: visit ?? this.visit,
      v: v ?? this.v,
    );
  }
}

class Status {
  String? appointmentStatus;
  String? deliveryStatus;

  Status({
    this.appointmentStatus,
    this.deliveryStatus,
  });

  Status copyWith({
    String? appointmentStatus,
    String? deliveryStatus,
  }) {
    return Status(
      appointmentStatus: appointmentStatus ?? this.appointmentStatus,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
    );
  }

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      appointmentStatus: json['appointmentStatus'],
      deliveryStatus: json['deliveryStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointmentStatus': appointmentStatus,
      'deliveryStatus': deliveryStatus,
    };
  }
}

// class Schedule {
//   DateTime? dateTime;

//   Schedule({
//     this.dateTime,
//   });

//   factory Schedule.fromJson(Map<String, dynamic> json) {
//     return Schedule(
//       dateTime: json['dateTime'] != null ? DateTime.parse(json['dateTime']) : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'dateTime': dateTime?.toIso8601String(),
//     };
//   }

//   Schedule copyWith({
//     DateTime? dateTime,
//   }) {
//     return Schedule(
//       dateTime: dateTime ?? this.dateTime,
//     );
//   }
// }

class DoctorModel {
  final String? id;
  final DoctorProfileModel? doctorProfile;

  DoctorModel({
    this.id,
    this.doctorProfile,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['_id'],
      doctorProfile: json['profile'] != null ? DoctorProfileModel.fromJson(json['profile']) : null,
    );
  }

  DoctorModel copyWith({String? id, DoctorProfileModel? doctorProfile}) {
    return DoctorModel(
      id: id ?? this.id,
      doctorProfile: doctorProfile ?? this.doctorProfile,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'profile': doctorProfile?.toJson(),
    };
  }
}

class DoctorProfileModel {
  final String? name;

  DoctorProfileModel({this.name});

  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) {
    return DoctorProfileModel(
      name: json['name'],
    );
  }

  DoctorProfileModel copyWith({
    String? name,
  }) {
    return DoctorProfileModel(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}

class Message {
  String? text;
  DateTime? date;

  Message({
    this.text,
    this.date,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'date': date?.toIso8601String(),
    };
  }

  Message copyWith({
    String? text,
    DateTime? date,
  }) {
    return Message(
      text: text ?? this.text,
      date: date ?? this.date,
    );
  }
}
