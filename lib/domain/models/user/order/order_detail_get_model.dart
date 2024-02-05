// To parse this JSON data, do
//
//     final OrderDetailModel = OrderDetailModelFromJson(jsonString);

import 'dart:convert';

OrderDetailModel orderDetailModelFromJson(String str) =>
    OrderDetailModel.fromJson(json.decode(str));

class OrderDetailModel {
  String message;
  int responseCode;
  List<Datum>? data;

  OrderDetailModel({
    required this.message,
    required this.responseCode,
    required this.data,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailModel(
        message: json["message"],
        responseCode: json["response_code"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  int idToko;
  String namaToko;
  int userId;
  String uid;
  int orderId;
  String orderStatus;
  String metodePembayaran;
  Time time;
  String virtualNumber;
  dynamic from;
  dynamic to;
  DateTime tanggalOrder;
  List<OrderDetail>? orderDetail;
  int totalPrice;
  dynamic review;
  String serviceType;
  dynamic foto;
  Datum(
      {required this.idToko,
      required this.namaToko,
      required this.userId,
      required this.uid,
      required this.orderId,
      required this.orderStatus,
      required this.metodePembayaran,
      required this.time,
      required this.virtualNumber,
      required this.from,
      required this.to,
      required this.tanggalOrder,
      required this.orderDetail,
      required this.totalPrice,
      required this.review,
      required this.serviceType,
      required this.foto});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      idToko: json["id_toko"] ?? json["trainer_id"] ?? json["dokter_id"],
      namaToko: json["nama_toko"] ?? json["username"] ?? json["nama"],
      userId: json["user_id"],
      uid: json["uid"],
      orderId: json["id"] ?? json["order_id"],
      orderStatus: json["order_status"] ?? json["status_order"],
      metodePembayaran: json["metode_pembayaran"],
      time: Time.fromJson(json["time"]),
      virtualNumber: json["virtual_number"],
      from: json["check_in"] != null
          ? DateTime.parse(json["check_in"])
          : json["tanggal_konsultasi"] != null
              ? DateTime.parse(json["tanggal_konsultasi"])
              : DateTime.parse(json["tanggal_pertemuan"]),
      to: json["check_out"] != null
          ? DateTime.parse(json["check_out"])
          : json["tanggal_konsultasi"] != null
              ? DateTime.parse(json["tanggal_konsultasi"])
              : DateTime.parse(json["tanggal_pertemuan"]),
      tanggalOrder: DateTime.parse(json["tanggal_order"]),
      orderDetail: json["order_detail"] != null
          ? List<OrderDetail>.from(
              json["order_detail"].map((x) => OrderDetail.fromJson(x)))
          : null,
      totalPrice: json["total_price"] ?? json["total_payment"],
      review: json["review"] != null ? Review.fromJson(json["review"]) : null,
      serviceType: json["service_type"],
      foto: json["foto"]);
}

class OrderDetail {
  int? id;
  String? title;
  int quantity;
  int? price;

  OrderDetail({
    this.id,
    this.title,
    required this.quantity,
    this.price,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
      id: json["hotel_id"] ?? json["grooming_id"],
      title: json["hotel_title"] ?? json["grooming_title"],
      quantity: json["quantity"],
      price: json["price"]);
}

class Time {
  int minutes;
  int seconds;

  Time({
    required this.minutes,
    required this.seconds,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        minutes: json["minutes"],
        seconds: json["seconds"],
      );
}

class Review {
  int rate;
  String reviewDescription;

  Review({
    required this.rate,
    required this.reviewDescription,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        rate: json["rating"],
        reviewDescription: json["review_description"] ?? json["ulasan"],
      );
}
