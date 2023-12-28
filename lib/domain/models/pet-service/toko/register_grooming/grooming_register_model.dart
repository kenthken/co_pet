// To parse this JSON data, do
//
//     final GroomingRegisterModel = GroomingRegisterModelFromJson(jsonString);

import 'dart:convert';

String groomingRegisterModelToJson(GroomingRegisterModel data) =>
    json.encode(data.toJson());

class GroomingRegisterModel {
  String tokoId;
  String tipe;
  String fasilitas;
  int harga;

  GroomingRegisterModel({
    required this.tokoId,
    required this.tipe,
    required this.fasilitas,
    required this.harga,
  });

  factory GroomingRegisterModel.fromJson(Map<String, dynamic> json) =>
      GroomingRegisterModel(
        tokoId: json["toko_id"],
        tipe: json["tipe"],
        fasilitas: json["fasilitas"],
        harga: json["harga"],
      );

  Map<String, dynamic> toJson() => {
        "toko_id": tokoId,
        "tipe": tipe,
        "fasilitas": fasilitas,
        "harga": harga,
      };
}
