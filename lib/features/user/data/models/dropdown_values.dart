class DropdownValues {
  String? id;
  List<MedicineType>? medicineTypes;
  List<IntakeValue>? intakeValues;
  List<Frequency>? frequencies;
  List<FoodTime>? foodTimes;

  DropdownValues({
    this.id,
    this.foodTimes,
    this.frequencies,
    this.intakeValues,
    this.medicineTypes,
  });

  factory DropdownValues.fromJson(Map<String, dynamic> json) {
    return DropdownValues(
      id: json['_id'],
      foodTimes: json['foodTime'] != null ? List<FoodTime>.from(json['foodTime'].map((foodTime) => FoodTime.fromJson(foodTime))) : [],
      frequencies: json['amount'] != null ? List<Frequency>.from(json['amount'].map((frequency) => Frequency.fromJson(frequency))) : [],
      intakeValues: json['intake'] != null ? List<IntakeValue>.from(json['intake'].map((intake) => IntakeValue.fromJson(intake))) : [],
      medicineTypes: json['medicineType'] != null ? List<MedicineType>.from(json['medicineType'].map((medicineType) => MedicineType.fromJson(medicineType))) : [],
    );
  }

  DropdownValues copyWith({
    String? id,
    List<MedicineType>? medicineTypes,
    List<IntakeValue>? intakeValues,
    List<Frequency>? frequencies,
    List<FoodTime>? foodTimes,
  }) {
    return DropdownValues(
      id: id ?? this.id,
      medicineTypes: medicineTypes ?? this.medicineTypes,
      intakeValues: intakeValues ?? this.intakeValues,
      frequencies: frequencies ?? this.frequencies,
      foodTimes: foodTimes ?? this.foodTimes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'foodTime': foodTimes?.map((value) => value.toJson()).toList(),
      'amount': frequencies?.map((value) => value.toJson()).toList(),
      'intake': intakeValues?.map((value) => value.toJson()).toList(),
      'medicineType': medicineTypes?.map((value) => value.toJson()).toList(),
    };
  }
}

class MedicineType {
  String? id;
  String? value;

  MedicineType({
    this.id,
    this.value,
  });

  factory MedicineType.fromJson(Map<String, dynamic> json) {
    return MedicineType(
      id: json['_id'],
      value: json['value'],
    );
  }

  MedicineType copyWith({
    String? id,
    String? value,
  }) {
    return MedicineType(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'value': value,
    };
  }
}

class IntakeValue {
  String? id;
  String? value;

  IntakeValue({
    this.id,
    this.value,
  });

  factory IntakeValue.fromJson(Map<String, dynamic> json) {
    return IntakeValue(
      id: json['_id'],
      value: json['value'],
    );
  }

  IntakeValue copyWith({
    String? id,
    String? value,
  }) {
    return IntakeValue(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'value': value,
    };
  }
}

class Frequency {
  String? id;
  String? value;

  Frequency({
    this.id,
    this.value,
  });

  factory Frequency.fromJson(Map<String, dynamic> json) {
    return Frequency(
      id: json['_id'],
      value: json['value'],
    );
  }

  Frequency copyWith({
    String? id,
    String? value,
  }) {
    return Frequency(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'value': value,
    };
  }
}

class FoodTime {
  String? id;
  String? value;

  FoodTime({
    this.id,
    this.value,
  });

  factory FoodTime.fromJson(Map<String, dynamic> json) {
    return FoodTime(
      id: json['_id'],
      value: json['value'],
    );
  }

  FoodTime copyWith({
    String? id,
    String? value,
  }) {
    return FoodTime(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'value': value,
    };
  }
}
