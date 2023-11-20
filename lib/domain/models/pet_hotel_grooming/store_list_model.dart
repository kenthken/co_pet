// To parse this JSON data, do
//
//     final StoreListModel = StoreListModelFromJson(jsonString);

import 'dart:convert';

StoreListModel storeListModelFromJson(String str) =>
    StoreListModel.fromJson(json.decode(str));

String storeListModelToJson(StoreListModel data) => json.encode(data.toJson());

class StoreListModel {
  String message;
  int kode;
  List<Datum>? data;

  StoreListModel({
    required this.message,
    required this.kode,
    this.data,
  });

  factory StoreListModel.fromJson(Map<String, dynamic> json) => StoreListModel(
        message: json["message"],
        kode: json["kode"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "kode": kode,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String petShopName;
  String rating;
  String totalRating;
  String nama;
  String noTelp;
  int startFrom;
  List<String> services;

  Datum({
    required this.id,
    required this.petShopName,
    required this.rating,
    required this.totalRating,
    required this.nama,
    required this.noTelp,
    required this.startFrom,
    required this.services,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        petShopName: json["pet_shop_name"],
        rating: json["rating"],
        totalRating: json["total_rating"],
        nama: json["nama"],
        noTelp: json["no_telp"],
        startFrom: json["start_from"],
        services: List<String>.from(json["services"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pet_shop_name": petShopName,
        "rating": rating,
        "total_rating": totalRating,
        "nama": nama,
        "no_telp": noTelp,
        "start_from": startFrom,
        "services": List<dynamic>.from(services.map((x) => x)),
      };
}
