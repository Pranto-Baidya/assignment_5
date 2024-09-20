

import 'dart:convert';

Assignment assignmentFromJson(String str) => Assignment.fromJson(json.decode(str));

String assignmentToJson(Assignment data) => json.encode(data.toJson());

class Assignment {
  String status;
  List<Datum> data;

  Assignment({
    required this.status,
    required this.data,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String productName;
  String productCode;
  String img;
  double unitPrice;
  int qty;
  double totalPrice;
  DateTime createdDate;

  Datum({
    required this.id,
    required this.productName,
    required this.productCode,
    required this.img,
    required this.unitPrice,
    required this.qty,
    required this.totalPrice,
    required this.createdDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    productName: json["ProductName"] ?? "N/A",
    productCode: json["ProductCode"] ?? "N/A",
    img: json["Img"] ?? "N/A",
    unitPrice: json["UnitPrice"] is num
        ? json["UnitPrice"].toDouble()
        : (json["UnitPrice"] is String && json["UnitPrice"].isNotEmpty
        ? double.tryParse(json["UnitPrice"]) ?? 0.0
        : 0.0),
    qty: json["Qty"] is num
        ? json["Qty"].toInt()
        : (json["Qty"] is String
        ? int.tryParse(json["Qty"]) ?? 0
        : 0),
    totalPrice: json["TotalPrice"] is num
        ? json["TotalPrice"].toDouble()
        : (json["TotalPrice"] is String && json["TotalPrice"].isNotEmpty
        ? double.tryParse(json["TotalPrice"]) ?? 0.0
        : 0.0),
    createdDate: json.containsKey("CreatedDate")
        ? DateTime.parse(json["CreatedDate"])
        : DateTime.now(),
  );


  Map<String, dynamic> toJson() => {
    "_id": id,
    "ProductName": productName,
    "ProductCode": productCode,
    "Img": img,
    "UnitPrice": unitPrice.toString(),
    "Qty": qty.toString(),
    "TotalPrice": totalPrice.toString(),
    "CreatedDate": createdDate.toIso8601String(),
  };
}
