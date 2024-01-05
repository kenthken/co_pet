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
  DateTime from;
  DateTime to;
  DateTime tanggalOrder;
  List<OrderDetail> orderDetail;
  int totalPrice;
  dynamic review;
  String serviceType;

  Datum({
    required this.idToko,
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
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idToko: json["id_toko"],
        namaToko: json["nama_toko"] ?? json["username"],
        userId: json["user_id"],
        uid: json["uid"],
        orderId: json["order_id"],
        orderStatus: json["order_status"],
        metodePembayaran: json["metode_pembayaran"],
        time: Time.fromJson(json["time"]),
        virtualNumber: json["virtual_number"],
        from: DateTime.parse(json["check_in"]),
        to: DateTime.parse(json["check_out"]),
        tanggalOrder: DateTime.parse(json["tanggal_order"]),
        orderDetail: List<OrderDetail>.from(
            json["order_detail"].map((x) => OrderDetail.fromJson(x))),
        totalPrice: json["total_price"],
        review: json["review"] != null ? Review.fromJson(json["review"]) : null,
        serviceType: json["service_type"],
      );
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
        rate: json["rate"],
        reviewDescription: json["review_description"],
      );
}
