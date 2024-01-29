// To parse this JSON data, do
//
//     final CreateOrderModel = CreateOrderModelFromJson(jsonString);

import 'dart:convert';

String createOrderModelToJson(CreateOrderModel data) =>
    json.encode(data.toJson());

class CreateOrderModel {
  List<OrderDetail> orderDetail;
  String metodePembayaran;
  int tokoId;
  int userId;
  DateTime? tanggalMasuk;
  DateTime? tanggalKeluar;

  String serviceType;

  CreateOrderModel({
    required this.orderDetail,
    required this.metodePembayaran,
    required this.tokoId,
    required this.userId,
    required this.tanggalMasuk,
    required this.tanggalKeluar,
    required this.serviceType,
  });

  Map<String, dynamic> toJson() => {
        "order_detail": List<dynamic>.from(orderDetail.map((x) => x.toJson())),
        "metode_pembayaran": metodePembayaran,
        "toko_id": tokoId,
        "user_id": userId,
        "tanggal_masuk":
            tanggalMasuk != null ? tanggalMasuk!.toIso8601String() : null,
        "tanggal_keluar":
            tanggalKeluar != null ? tanggalKeluar!.toIso8601String() : null,
        "service_type": serviceType,
      };
}

class OrderDetail {
  String? groomingId;
  int quantity;
  String? hotelId;

  OrderDetail({
    this.groomingId,
    required this.quantity,
    this.hotelId,
  });

  Map<String, dynamic> toJson() => {
        "grooming_id": groomingId,
        "quantity": quantity,
        "hotel_id": hotelId,
      };
}
