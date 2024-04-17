class ModuleValues {
  ModuleValues._();

  static const String appointments = "appointments";
  static const String medicalRecords = "medical_records";
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
      roleName: json['roleName'] != null ? json['profile'] : null,
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
