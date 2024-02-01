// To parse this JSON data, do
//
//     final CreateOrderTrainerModel = CreateOrderTrainerModelFromJson(jsonString);

import 'dart:convert';

CreateOrderTrainerModel createOrderTrainerModelFromJson(String str) =>
    CreateOrderTrainerModel.fromJson(json.decode(str));

String createOrderTrainerModelToJson(CreateOrderTrainerModel data) =>
    json.encode(data.toJson());

class CreateOrderTrainerModel {
  String metodePembayaran;
  int userId;
  int trainerId;
  DateTime jamPertemuan;
  DateTime tanggalPertemuan;
  String serviceType;

  CreateOrderTrainerModel({
    required this.metodePembayaran,
    required this.userId,
    required this.trainerId,
    required this.jamPertemuan,
    required this.tanggalPertemuan,
    required this.serviceType,
  });

  factory CreateOrderTrainerModel.fromJson(Map<String, dynamic> json) =>
      CreateOrderTrainerModel(
        metodePembayaran: json["metode_pembayaran"],
        userId: json["user_id"],
        trainerId: json["trainer_id"],
        jamPertemuan: DateTime.parse(json["jam_pertemuan"]),
        tanggalPertemuan: DateTime.parse(json["tanggal_pertemuan"]),
        serviceType: json["service_type"],
      );

  Map<String, dynamic> toJson() => {
        "metode_pembayaran": metodePembayaran,
        "user_id": userId,
        "trainer_id": trainerId,
        "jam_pertemuan": jamPertemuan.toIso8601String(),
        "tanggal_pertemuan": tanggalPertemuan.toIso8601String(),
        "service_type": serviceType,
      };
}
