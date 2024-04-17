/* -------------------------- Response From Backend ------------------------- */
//
// {
//   "_id": "65da447c19faef0efd09274e",
//   "productName": "ATENOWAL 50MG TABLET-14",
//   "productComposition": "Atenolol (50mg)",
//   "packagingDetail": "PaCk of 14 Tablets",
//   "productPrice": 24.4,
//   "productBrand": "Wallace",
//   "usage": "Take this medicine in the dose and duration as advised by your doctor. Swallow it as a whole. Do not chew, crush or break it. ATENOWAL 50  may be taken with or without food, but it is better to take it at a fixed time.",
//   "pregnancyInteraction": "ATENOWAL 50 is unsafe to use during pregnancy.There is positive evidence of human fetal risk, but the benefits from use in pregnant women may be acceptable despite the risk, for example in life-threatening situations. Please consult your doctor.",
//   "medicineInteraction": "ATENOWAL 50 with Alprazolam|ATENOWAL 50 with Tizanidine|ATENOWAL 50 with Theophylline|ATENOWAL 50 with Diltiazem|ATENOWAL 50 with Diclofenac|ATENOWAL 50 with Ceritinib",
//   "sideEffects": "Nausea, Headache, Fatigue, Constipation, Diarrhoea, Dizziness, Cold extremities.",
//   "description": "ATENOWAL 50 is a beta-blocker that works on the heart and blood vessels. It is used to treat high blood pressure and chest pain. Anol 100 MG Tablet causes blood vessels to relax resulting in an improved blood flow to the heart. As a result, the pressure at which blood is pumped out of the heart is reduced. It also slows down the activity of your heart allowing your heart to beat slower and less forcefully.",
//   "manufacturerName": "Wallace",
//   "__v": 0
// }

class Medicine {
  final String? id;
  final String? usage;
  final num? productPrice;
  final String? productName;
  final String? sideEffects;
  final String? description;
  final String? productBrand;
  final String? packagingDetail;
  final String? manufacturerName;
  final String? productComposition;
  final String? medicineInteraction;
  final String? pregnancyInteraction;

  Medicine({
    this.id,
    this.usage,
    this.productName,
    this.sideEffects,
    this.description,
    this.productPrice,
    this.productBrand,
    this.packagingDetail,
    this.manufacturerName,
    this.productComposition,
    this.medicineInteraction,
    this.pregnancyInteraction,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['_id'],
      usage: json['usage'],
      productName: json['productName'],
      sideEffects: json['sideEffects'],
      description: json['description'],
      productPrice: json['productPrice'],
      productBrand: json['productBrand'],
      packagingDetail: json['packagingDetail'],
      manufacturerName: json['manufacturerName'],
      productComposition: json['productComposition'],
      medicineInteraction: json['medicineInteraction'],
      pregnancyInteraction: json['pregnancyInteraction'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'usage': usage,
      'productName': productName,
      'sideEffects': sideEffects,
      'description': description,
      'productPrice': productPrice,
      'productBrand': productBrand,
      'packagingDetail': packagingDetail,
      'manufacturerName': manufacturerName,
      'productComposition': productComposition,
      'medicineInteraction': medicineInteraction,
      'pregnancyInteraction': pregnancyInteraction,
    };
  }

  Medicine copyWith({
    String? id,
    String? usage,
    String? productName,
    String? sideEffects,
    String? description,
    num? productPrice,
    String? productBrand,
    String? packagingDetail,
    String? manufacturerName,
    String? productComposition,
    String? medicineInteraction,
    String? pregnancyInteraction,
  }) {
    return Medicine(
      id: id ?? this.id,
      usage: usage ?? this.usage,
      productName: productName ?? this.productName,
      sideEffects: sideEffects ?? this.sideEffects,
      description: description ?? this.description,
      productPrice: productPrice ?? this.productPrice,
      productBrand: productBrand ?? this.productBrand,
      packagingDetail: packagingDetail ?? this.packagingDetail,
      manufacturerName: manufacturerName ?? this.manufacturerName,
      productComposition: productComposition ?? this.productComposition,
      medicineInteraction: medicineInteraction ?? this.medicineInteraction,
      pregnancyInteraction: pregnancyInteraction ?? this.pregnancyInteraction,
    );
  }
}
