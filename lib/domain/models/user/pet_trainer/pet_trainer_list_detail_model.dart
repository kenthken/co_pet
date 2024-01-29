// To parse this JSON data, do
//
//     final PetTrainerListDetailModel = PetTrainerListDetailModelFromJson(jsonString);

import 'dart:convert';

PetTrainerListDetailModel petTrainerListDetailModelFromJson(String str) => PetTrainerListDetailModel.fromJson(json.decode(str));

String petTrainerListDetailModelToJson(PetTrainerListDetailModel data) => json.encode(data.toJson());

class PetTrainerListDetailModel {
    int responseCode;
    String message;
    Data data;

    PetTrainerListDetailModel({
        required this.responseCode,
        required this.message,
        required this.data,
    });

    factory PetTrainerListDetailModel.fromJson(Map<String, dynamic> json) => PetTrainerListDetailModel(
        responseCode: json["response_code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int id;
    int penyediaId;
    String nama;
    String spesialis;
    String pengalaman;
    int harga;
    String lokasi;
    bool isAcc;
    bool isAvailable;
    String foto;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    String rate;
    int totalRating;
    List<String> description;

    Data({
        required this.id,
        required this.penyediaId,
        required this.nama,
        required this.spesialis,
        required this.pengalaman,
        required this.harga,
        required this.lokasi,
        required this.isAcc,
        required this.isAvailable,
        required this.foto,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.rate,
        required this.totalRating,
        required this.description,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        penyediaId: json["penyedia_id"],
        nama: json["nama"],
        spesialis: json["spesialis"],
        pengalaman: json["pengalaman"],
        harga: json["harga"],
        lokasi: json["lokasi"],
        isAcc: json["is_acc"],
        isAvailable: json["is_available"],
        foto: json["foto"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        rate: json["rate"],
        totalRating: json["total_rating"],
        description: List<String>.from(json["description"].map((x) => x)),
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
        "rate": rate,
        "total_rating": totalRating,
        "description": List<dynamic>.from(description.map((x) => x)),
    };
}
