// To parse this JSON data, do
//
//     final PetTrainerListModel = PetTrainerListModelFromJson(jsonString);

import 'dart:convert';

PetTrainerListModel petTrainerListModelFromJson(String str) =>
    PetTrainerListModel.fromJson(json.decode(str));

String petTrainerListModelToJson(PetTrainerListModel data) =>
    json.encode(data.toJson());

class PetTrainerListModel {
  int responseCode;
  String message;
  List<Datum> data;

  PetTrainerListModel({
    required this.responseCode,
    required this.message,
    required this.data,
  });

  factory PetTrainerListModel.fromJson(Map<String, dynamic> json) =>
      PetTrainerListModel(
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
  String spesialis;
  String pengalaman;
  String rating;
  int totalRating;
  int harga;
  String lokasi;
  bool isAcc;
  bool isAvailable;
  String foto;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Datum({
    required this.id,
    required this.penyediaId,
    required this.nama,
    required this.spesialis,
    required this.pengalaman,
    required this.harga,
    required this.rating,
    required this.totalRating,
    required this.lokasi,
    required this.isAcc,
    required this.isAvailable,
    required this.foto,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        penyediaId: json["penyedia_id"],
        nama: json["nama"],
        spesialis: json["spesialis"],
        pengalaman: json["pengalaman"],
        rating: json["rating"],
        totalRating: json["total_rating"],
        harga: json["harga"],
        lokasi: json["lokasi"],
        isAcc: json["is_acc"],
        isAvailable: json["is_available"],
        foto: json["foto"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
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
        "is_available": isAvailable,
        "foto": foto,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
