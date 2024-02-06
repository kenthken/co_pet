// To parse this JSON data, do
//
//     final UserPetServiceModel = UserPetServiceModelFromJson(jsonString);

import 'dart:convert';

UserPetServiceModel userPetServiceModelFromJson(String str) =>
    UserPetServiceModel.fromJson(json.decode(str));

String userPetServiceModelToJson(UserPetServiceModel data) =>
    json.encode(data.toJson());

class UserPetServiceModel {
  int responseCode;
  String message;
  List<Datum> data;

  UserPetServiceModel({
    required this.responseCode,
    required this.message,
    required this.data,
  });

  factory UserPetServiceModel.fromJson(Map<String, dynamic> json) =>
      UserPetServiceModel(
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
  String? alumni;
  String? lokasiPraktek;
  bool isAcc;
  String serviceType;
  String foto;
  String? lokasi;
  String? deskripsi;

  Datum({
    required this.id,
    required this.penyediaId,
    required this.nama,
    this.spesialis,
    this.pengalaman,
    this.harga,
    this.alumni,
    this.lokasiPraktek,
    required this.isAcc,
    required this.serviceType,
    required this.foto,
    this.lokasi,
    this.deskripsi,
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
        isAcc: json["is_acc"],
        serviceType: json["service_type"],
        foto: json["foto"],
        lokasi: json["lokasi"],
        deskripsi: json["deskripsi"],
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
        "is_acc": isAcc,
        "service_type": serviceType,
        "foto": foto,
        "lokasi": lokasi,
        "deskripsi": deskripsi,
      };
}
