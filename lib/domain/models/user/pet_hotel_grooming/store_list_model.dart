// To parse this JSON data, do
//
//     final StoreListModel = StoreListModelFromJson(jsonString);

import 'dart:convert';

StoreListModel storeListModelFromJson(String str) =>
    StoreListModel.fromJson(json.decode(str));

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
        kode: json["response_code"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  int id;
  String petShopName;
  dynamic petShopPhoto;
  String rating;
  String totalRating;
  String? nama;
  String? noTelp;
  int startFrom;
  List<String> services;
  bool isOpen;

  Datum(
      {required this.id,
      required this.petShopName,
      required this.petShopPhoto,
      required this.rating,
      required this.totalRating,
      required this.nama,
      required this.noTelp,
      required this.startFrom,
      required this.services,
      required this.isOpen});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        petShopName: json["pet_shop_name"],
        petShopPhoto: json["foto"],
        rating: json["rating"],
        totalRating: json["total_rating"],
        nama: json["nama"],
        noTelp: json["no_telp"],
        startFrom: json["start_from"],
        isOpen: json["is_open"],
        services: List<String>.from(json["services"].map((x) => x)),
      );
}
