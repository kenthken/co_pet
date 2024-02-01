// To parse this JSON data, do
//
//     final TrainerRegisterModel = TrainerRegisterModelFromJson(jsonString);

import 'dart:convert';

TrainerRegisterModel trainerRegisterModelFromJson(String str) =>
    TrainerRegisterModel.fromJson(json.decode(str));

String trainerRegisterModelToJson(TrainerRegisterModel data) =>
    json.encode(data.toJson());

class TrainerRegisterModel {
  String? penyediaId;
  String nama;
  String spesialis;
  dynamic foto;
  String pengalaman;
  int harga;
  String alumni;
  String lokasi;

  TrainerRegisterModel({
    this.penyediaId,
    required this.nama,
    required this.spesialis,
    required this.foto,
    required this.pengalaman,
    required this.harga,
    required this.alumni,
    required this.lokasi,
  });

  factory TrainerRegisterModel.fromJson(Map<String, dynamic> json) =>
      TrainerRegisterModel(
        penyediaId: json["penyedia_id"],
        nama: json["nama"],
        spesialis: json["spesialis"],
        foto: json["foto"],
        pengalaman: json["pengalaman"],
        harga: json["harga"],
        alumni: json["alumni"],
        lokasi: json["lokasi"],
      );

  Map<String, dynamic> toJson() => {
        "penyedia_id": penyediaId,
        "nama": nama,
        "spesialis": spesialis,
        "foto": foto,
        "pengalaman": pengalaman,
        "harga": harga,
        "alumni": alumni,
        "lokasi": lokasi,
      };
}
