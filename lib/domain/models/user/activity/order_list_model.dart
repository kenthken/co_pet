// To parse this JSON data, do
//
//     final OrderListModel = OrderListModelFromJson(jsonString);

import 'dart:convert';

OrderListModel orderListModelFromJson(String str) =>
    OrderListModel.fromJson(json.decode(str));

class OrderListModel {
  String message;
  int responseCode;
  List<Datum>? data;

  OrderListModel({
    required this.message,
    required this.responseCode,
    required this.data,
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
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
        title: json["title"] ?? json["username"],
        serviceType: json["service_type"],
        status: json["status"],
        totalPayment: json["total_payment"],
      );
}
