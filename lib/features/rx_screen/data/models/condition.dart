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
