// To parse this JSON data, do
//
//     final PetModel = PetModelFromJson(jsonString);

import 'dart:convert';

PetModel petModelFromJson(String str) => PetModel.fromJson(json.decode(str));

String petModelToJson(PetModel data) => json.encode(data.toJson());

class PetModel {
    int userId;
    String namaHewan;
    String jenisHewan;
    String sizeHewan;
    String umurHewan;
    String gender;

    PetModel({
        required this.userId,
        required this.namaHewan,
        required this.jenisHewan,
        required this.sizeHewan,
        required this.umurHewan,
        required this.gender,
    });

    factory PetModel.fromJson(Map<String, dynamic> json) => PetModel(
        userId: json["user_id"],
        namaHewan: json["nama_hewan"],
        jenisHewan: json["jenis_hewan"],
        sizeHewan: json["size_hewan"],
        umurHewan: json["umur_hewan"],
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "nama_hewan": namaHewan,
        "jenis_hewan": jenisHewan,
        "size_hewan": sizeHewan,
        "umur_hewan": umurHewan,
        "gender": gender,
    };
}


GetPetListModel getPetListModelFromJson(String str) => GetPetListModel.fromJson(json.decode(str));

String getPetListModelToJson(GetPetListModel data) => json.encode(data.toJson());

class GetPetListModel {
    int responseCode;
    String message;
    List<Datum> data;

    GetPetListModel({
        required this.responseCode,
        required this.message,
        required this.data,
    });

    factory GetPetListModel.fromJson(Map<String, dynamic> json) => GetPetListModel(
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
    int userId;
    String namaHewan;
    String jenisHewan;
    String sizeHewan;
    String umurHewan;
    String gender;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;

    Datum({
        required this.id,
        required this.userId,
        required this.namaHewan,
        required this.jenisHewan,
        required this.sizeHewan,
        required this.umurHewan,
        required this.gender,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        namaHewan: json["nama_hewan"],
        jenisHewan: json["jenis_hewan"],
        sizeHewan: json["size_hewan"],
        umurHewan: json["umur_hewan"],
        gender: json["gender"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "nama_hewan": namaHewan,
        "jenis_hewan": jenisHewan,
        "size_hewan": sizeHewan,
        "umur_hewan": umurHewan,
        "gender": gender,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
    };
}

