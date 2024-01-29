// To parse this JSON data, do
//
//     final DoctorDetailModel = DoctorDetailModelFromJson(jsonString);

import 'dart:convert';

DoctorDetailModel doctorDetailModelFromJson(String str) =>
    DoctorDetailModel.fromJson(json.decode(str));

String doctorDetailModelToJson(DoctorDetailModel data) =>
    json.encode(data.toJson());

class DoctorDetailModel {
  int responseCode;
  String message;
  Data data;

  DoctorDetailModel({
    required this.responseCode,
    required this.message,
    required this.data,
  });

  factory DoctorDetailModel.fromJson(Map<String, dynamic> json) =>
      DoctorDetailModel(
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
  String alumni;
  String lokasiPraktek;
  String noStr;
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
    required this.alumni,
    required this.lokasiPraktek,
    required this.noStr,
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
        alumni: json["alumni"],
        lokasiPraktek: json["lokasi_praktek"],
        noStr: json["no_str"],
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
        "alumni": alumni,
        "lokasi_praktek": lokasiPraktek,
        "no_str": noStr,
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
