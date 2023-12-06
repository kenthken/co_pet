// To parse this JSON data, do
//
//     final OrderResponseModel = OrderResponseModelFromJson(jsonString);

import 'dart:convert';

OrderResponseModel orderResponseModelFromJson(String str) =>
    OrderResponseModel.fromJson(json.decode(str));

String orderResponseModelToJson(OrderResponseModel data) =>
    json.encode(data.toJson());

class OrderResponseModel {
  String message;
  int responseCode;
  Data data;

  OrderResponseModel({
    required this.message,
    required this.responseCode,
    required this.data,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) =>
      OrderResponseModel(
        message: json["message"],
        responseCode: json["response_code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "response_code": responseCode,
        "data": data.toJson(),
      };
}

class Data {
  Order order;
  List<Detail> detail;
  int totalPrice;
  int id;
  String nama;
  String kode;
  String transactionStatus;
  String fraudStatus;

  Data({
    required this.order,
    required this.detail,
    required this.totalPrice,
    required this.id,
    required this.nama,
    required this.kode,
    required this.transactionStatus,
    required this.fraudStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        order: Order.fromJson(json["order"]),
        detail:
            List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
        totalPrice: json["total_price"],
        id: json["id"],
        nama: json["nama"],
        kode: json["kode"],
        transactionStatus: json["transactionStatus"],
        fraudStatus: json["fraudStatus"],
      );

  Map<String, dynamic> toJson() => {
        "order": order.toJson(),
        "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
        "total_price": totalPrice,
        "id": id,
        "nama": nama,
        "kode": kode,
        "transactionStatus": transactionStatus,
        "fraudStatus": fraudStatus,
      };
}

class Detail {
  int id;
  int orderId;
  int hotelId;
  DateTime tanggalMasuk;
  DateTime tanggalKeluar;
  String metodePenjemputan;
  int discount;
  int quantity;
  DateTime updatedAt;
  DateTime createdAt;
  dynamic deletedAt;
  int grossPrice;

  Detail({
    required this.id,
    required this.orderId,
    required this.hotelId,
    required this.tanggalMasuk,
    required this.tanggalKeluar,
    required this.metodePenjemputan,
    required this.discount,
    required this.quantity,
    required this.updatedAt,
    required this.createdAt,
    required this.deletedAt,
    required this.grossPrice,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        orderId: json["order_id"],
        hotelId: json["hotel_id"],
        tanggalMasuk: DateTime.parse(json["tanggal_masuk"]),
        tanggalKeluar: DateTime.parse(json["tanggal_keluar"]),
        metodePenjemputan: json["metode_penjemputan"],
        discount: json["discount"],
        quantity: json["quantity"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        deletedAt: json["deletedAt"],
        grossPrice: json["gross_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "hotel_id": hotelId,
        "tanggal_masuk": tanggalMasuk.toIso8601String(),
        "tanggal_keluar": tanggalKeluar.toIso8601String(),
        "metode_penjemputan": metodePenjemputan,
        "discount": discount,
        "quantity": quantity,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "deletedAt": deletedAt,
        "gross_price": grossPrice,
      };
}

class Order {
  int id;
  int userId;
  String statusOrder;
  String metodePembayaran;
  String statusPembayaran;
  DateTime tanggalOrder;
  DateTime updatedAt;
  DateTime createdAt;
  dynamic deletedAt;

  Order({
    required this.id,
    required this.userId,
    required this.statusOrder,
    required this.metodePembayaran,
    required this.statusPembayaran,
    required this.tanggalOrder,
    required this.updatedAt,
    required this.createdAt,
    required this.deletedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        statusOrder: json["status_order"],
        metodePembayaran: json["metode_pembayaran"],
        statusPembayaran: json["status_pembayaran"],
        tanggalOrder: DateTime.parse(json["tanggal_order"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "status_order": statusOrder,
        "metode_pembayaran": metodePembayaran,
        "status_pembayaran": statusPembayaran,
        "tanggal_order": tanggalOrder.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
