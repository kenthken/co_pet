// To parse this JSON data, do
//
//     final StoreDetailModel = StoreDetailModelFromJson(jsonString);

import 'dart:convert';

StoreDetailModel storeDetailModelFromJson(String str) =>
    StoreDetailModel.fromJson(json.decode(str));

class StoreDetailModel {
  String message;
  int responseCode;
  Data? data;

  StoreDetailModel({
    required this.message,
    required this.responseCode,
    this.data,
  });

  factory StoreDetailModel.fromJson(Map<String, dynamic> json) =>
      StoreDetailModel(
        message: json["message"],
        responseCode: json["response_code"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  int id;
  String petShopName;
  int startFrom;
  String description;
  String location;
  DateTime openTime;
  DateTime closeTime;
  dynamic petShopPicture;
  String rating;
  String totalRating;
  List<Review>? review;
  List<String> services;
  List<Hotel> hotels;
  List<Grooming> groomings;
  bool isOpen;
  Data({
    required this.id,
    required this.petShopName,
    required this.startFrom,
    required this.description,
    required this.location,
    required this.openTime,
    required this.closeTime,
    required this.petShopPicture,
    required this.rating,
    required this.totalRating,
    required this.review,
    required this.services,
    required this.hotels,
    required this.groomings,
    required this.isOpen,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        petShopName: json["pet_shop_name"],
        startFrom: json["start_from"] ?? 0,
        description: json["description"],
        location: json["location"],
        petShopPicture: json["pet_shop_picture"],
        openTime: DateTime.parse(json["open_time"]),
        closeTime: DateTime.parse(json["close_time"]),
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
        isOpen: json["is_open"],
      );
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
}

class HotelPackage {
  final Hotel hotel;
  int quantity = 0;

  HotelPackage(this.hotel);
}

class Review {
  String namaUser;
  int rate;
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
