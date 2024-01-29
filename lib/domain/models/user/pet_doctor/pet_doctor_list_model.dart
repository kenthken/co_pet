// To parse this JSON data, do
//
//     final PetDoctorListModel = PetDoctorListModelFromJson(jsonString);

import 'dart:convert';

PetDoctorListModel petDoctorListModelFromJson(String str) =>
    PetDoctorListModel.fromJson(json.decode(str));

String petDoctorListModelToJson(PetDoctorListModel data) =>
    json.encode(data.toJson());

class PetDoctorListModel {
  int responseCode;
  String message;
  List<Datum> data;

  PetDoctorListModel({
    required this.responseCode,
    required this.message,
    required this.data,
  });

  factory PetDoctorListModel.fromJson(Map<String, dynamic> json) =>
      PetDoctorListModel(
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
  int harga;
  String alumni;
  String lokasiPraktek;
  String noStr;
  bool isAcc;
  bool isAvail;
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
    required this.alumni,
    required this.lokasiPraktek,
    required this.noStr,
    required this.isAcc,
    required this.isAvail,
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
        harga: json["harga"],
        alumni: json["alumni"],
        lokasiPraktek: json["lokasi_praktek"],
        noStr: json["no_str"],
        isAcc: json["is_acc"],
        isAvail: json["is_available"],
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
        "alumni": alumni,
        "lokasi_praktek": lokasiPraktek,
        "no_str": noStr,
        "is_acc": isAcc,
        "foto": foto,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
