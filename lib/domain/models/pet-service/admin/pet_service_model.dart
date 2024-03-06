// To parse this JSON data, do
//
//     final PetServiceModel = PetServiceModelFromJson(jsonString);

import 'dart:convert';

PetServiceModel petServiceModelFromJson(String str) =>
    PetServiceModel.fromJson(json.decode(str));

String petServiceModelToJson(PetServiceModel data) =>
    json.encode(data.toJson());

class PetServiceModel {
  int responseCode;
  String message;
  List<Datum> data;

  PetServiceModel({
    required this.responseCode,
    required this.message,
    required this.data,
  });

  factory PetServiceModel.fromJson(Map<String, dynamic> json) =>
      PetServiceModel(
        responseCode: json["response_code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  int penyediaId;
  String nama;
  String? spesialis;
  String? pengalaman;
  int? harga;
  String lokasi;
  bool isAcc;
  String serviceType;
  dynamic foto;
  String? deskripsi;

  Datum({
    required this.id,
    required this.penyediaId,
    required this.nama,
    this.spesialis,
    this.pengalaman,
    this.harga,
    required this.lokasi,
    required this.isAcc,
    required this.serviceType,
    required this.foto,
    this.deskripsi,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        penyediaId: json["penyedia_id"],
        nama: json["nama"],
        spesialis: json["spesialis"],
        pengalaman: json["pengalaman"],
        harga: json["harga"],
        lokasi: json["lokasi"] ?? json["lokasi_praktek"],
        isAcc: json["is_acc"],
        serviceType: json["service_type"],
        foto: json["foto"],
        deskripsi: json["deskripsi"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "penyedia_id": penyediaId,
        "nama": nama,
        "spesialis": spesialis,
        "pengalaman": pengalaman,
        "harga": harga,
        "lokasi": lokasi,
        "is_acc": isAcc,
        "service_type": serviceType,
        "foto": foto,
        "deskripsi": deskripsi,
      };
}
