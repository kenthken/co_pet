// To parse this JSON data, do
//
//     final OnGoingListModel = OnGoingListModelFromJson(jsonString);

import 'dart:convert';

OnGoingListModel onGoingListModelFromJson(String str) =>
    OnGoingListModel.fromJson(json.decode(str));

class OnGoingListModel {
  String message;
  int responseCode;
  List<Datum>? data;

  OnGoingListModel({
    required this.message,
    required this.responseCode,
    required this.data,
  });

  factory OnGoingListModel.fromJson(Map<String, dynamic> json) =>
      OnGoingListModel(
        message: json["message"],
        responseCode: json["response_code"],
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : [],
      );
}

class Datum {
  int orderId;
  String title;
  String serviceType;
  String status;
  int totalPayment;

  Datum({
    required this.orderId,
    required this.title,
    required this.serviceType,
    required this.status,
    required this.totalPayment,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        orderId: json["order_id"],
        title: json["title"] ??
            json["username"] ??
            json["nama_trainer"] ??
            json["nama_dokter"],
        serviceType: json["service_type"],
        status: json["status"],
        totalPayment: json["total_payment"],
      );
}
