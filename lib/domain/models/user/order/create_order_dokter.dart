// To parse this JSON data, do
//
//     final CreateOrderDoctorModel = CreateOrderDoctorModelFromJson(jsonString);

import 'dart:convert';

String createOrderDoctorModelToJson(CreateOrderDoctorModel data) =>
    json.encode(data.toJson());

class CreateOrderDoctorModel {
  String metodePembayaran;
  int userId;
  int dokterId;
  DateTime jamKonsultasi;
  DateTime tanggalKonsultasi;
  String serviceType;

  CreateOrderDoctorModel({
    required this.metodePembayaran,
    required this.userId,
    required this.dokterId,
    required this.jamKonsultasi,
    required this.tanggalKonsultasi,
    required this.serviceType,
  });

  Map<String, dynamic> toJson() => {
        "metode_pembayaran": metodePembayaran,
        "user_id": userId,
        "dokter_id": dokterId,
        "jam_konsultasi": jamKonsultasi.toIso8601String(),
        "tanggal_konsultasi": tanggalKonsultasi.toIso8601String(),
        "service_type": serviceType,
      };
}
