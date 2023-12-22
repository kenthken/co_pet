// To parse this JSON data, do
//
//     final HistoryListModel = HistoryListModelFromJson(jsonString);

import 'dart:convert';

HistoryListModel historyListModelFromJson(String str) =>
    HistoryListModel.fromJson(json.decode(str));

class HistoryListModel {
  String message;
  int responseCode;
  List<Datum>? data;

  HistoryListModel({
    required this.message,
    required this.responseCode,
    required this.data,
  });

  factory HistoryListModel.fromJson(Map<String, dynamic> json) =>
      HistoryListModel(
        message: json["message"],
        responseCode: json["response_code"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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
        title: json["title"],
        serviceType: json["service_type"],
        status: json["status"],
        totalPayment: json["total_payment"],
      );
}
