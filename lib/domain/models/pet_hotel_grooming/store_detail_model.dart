// To parse this JSON data, do
//
//     final StoreDetailModel = StoreDetailModelFromJson(jsonString);

import 'dart:convert';

StoreDetailModel storeDetailModelFromJson(String str) =>
    StoreDetailModel.fromJson(json.decode(str));

String storeDetailModelToJson(StoreDetailModel data) =>
    json.encode(data.toJson());

class StoreDetailModel {
  String message;
  int kode;
  Data? data;

  StoreDetailModel({
    required this.message,
    required this.kode,
    this.data,
  });

  factory StoreDetailModel.fromJson(Map<String, dynamic> json) =>
      StoreDetailModel(
        message: json["message"],
        kode: json["kode"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "kode": kode,
        "data": data!.toJson(),
      };
}

class Data {
  int id;
  String petShopName;
  int startFrom;
  String description;
  String location;
  dynamic petShopPicture;
  String rating;
  String totalRating;
  List<Review> review;
  List<String> services;
  List<Hotel> hotels;
  List<Grooming> groomings;

  Data({
    required this.id,
    required this.petShopName,
    required this.startFrom,
    required this.description,
    required this.location,
    required this.petShopPicture,
    required this.rating,
    required this.totalRating,
    required this.review,
    required this.services,
    required this.hotels,
    required this.groomings,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        petShopName: json["pet_shop_name"],
        startFrom: json["start_from"],
        description: json["description"],
        location: json["location"],
        petShopPicture: json["pet_shop_picture"],
        rating: json["rating"],
        totalRating: json["total_rating"],
        review: json["review"] != null
            ? List<Review>.from(json["review"].map((x) => Review.fromJson(x)))
            : [],
        services: List<String>.from(json["services"].map((x) => x)),
        hotels: json["hotels"] != null
            ? List<Hotel>.from(json["hotels"].map((x) => Hotel.fromJson(x)))
            : [],
        groomings: json["groomings"] != null
            ? List<Grooming>.from(
                json["groomings"].map((x) => Grooming.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pet_shop_name": petShopName,
        "start_from": startFrom,
        "description": description,
        "location": location,
        "pet_shop_picture": petShopPicture,
        "rating": rating,
        "total_rating": totalRating,
        "review": List<dynamic>.from(review.map((x) => x.toJson())),
        "services": List<dynamic>.from(services.map((x) => x)),
        "hotels": List<dynamic>.from(services.map((e) => null)),
        "groomings": List<dynamic>.from(groomings.map((x) => x.toJson())),
      };
}

class Grooming {
  int id;
  int tokoId;
  String titleGrooming;
  int priceGrooming;
  List<String> serviceDetailGrooming;

  Grooming({
    required this.id,
    required this.tokoId,
    required this.titleGrooming,
    required this.priceGrooming,
    required this.serviceDetailGrooming,
  });

  factory Grooming.fromJson(Map<String, dynamic> json) => Grooming(
        id: json["id"],
        tokoId: json["toko_id"],
        titleGrooming: json["title_grooming"],
        priceGrooming: json["price_grooming"],
        serviceDetailGrooming:
            List<String>.from(json["service_detail_grooming"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "toko_id": tokoId,
        "title_grooming": titleGrooming,
        "price_grooming": priceGrooming,
        "service_detail_grooming":
            List<dynamic>.from(serviceDetailGrooming.map((x) => x)),
      };
}

class GroomingPackage {
  final Grooming grooming;
  int quantity = 0;

  GroomingPackage(this.grooming);
}

class GroomingCart {
  List<GroomingPackage> groomingCart;
  DateTime groomingDate;

  GroomingCart(this.groomingCart, this.groomingDate);
}

class Hotel {
  int id;
  int tokoId;
  String titleHotel;
  int priceHotel;
  List<String> serviceDetailHotel;
  Hotel({
    required this.id,
    required this.tokoId,
    required this.titleHotel,
    required this.priceHotel,
    required this.serviceDetailHotel,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
        id: json["id"],
        tokoId: json["toko_id"],
        titleHotel: json["title_hotel"],
        priceHotel: json["price_hotel"],
        serviceDetailHotel:
            List<String>.from(json["service_detail_hotel"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "toko_id": tokoId,
        "title_grooming": titleHotel,
        "price_grooming": priceHotel,
        "service_detail_grooming":
            List<dynamic>.from(serviceDetailHotel.map((x) => x)),
      };
}

class HotelPackage {
  final Hotel hotel;
  int quantity = 0;

  HotelPackage(this.hotel);
}

class Review {
  String namaUser;
  String rate;
  String reviewDescription;

  Review({
    required this.namaUser,
    required this.rate,
    required this.reviewDescription,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        namaUser: json["nama_user"],
        rate: json["rate"],
        reviewDescription: json["review_description"],
      );

  Map<String, dynamic> toJson() => {
        "nama_user": namaUser,
        "rate": rate,
        "review_description": reviewDescription,
      };
}
