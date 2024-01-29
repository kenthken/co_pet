// To parse this JSON data, do
//
//     final DoctorDetailModel = DoctorDetailModelFromJson(jsonString);

import 'dart:convert';

DoctorDetailModel doctorDetailModelFromJson(String str) =>
    DoctorDetailModel.fromJson(json.decode(str));

String doctorDetailModelToJson(DoctorDetailModel data) =>
    json.encode(data.toJson());

class DoctorDetailModel {
  String penyediaId;
  String nama;
  String spesialis;
  String pengalaman;
  dynamic foto;
  int harga;
  String alumni;
  String lokasiPraktek;
  String noStr;

  DoctorDetailModel({
    required this.penyediaId,
    required this.nama,
    required this.spesialis,
    required this.pengalaman,
    required this.foto,
    required this.harga,
    required this.alumni,
    required this.lokasiPraktek,
    required this.noStr,
  });

  factory DoctorDetailModel.fromJson(Map<String, dynamic> json) =>
      DoctorDetailModel(
        penyediaId: json["penyedia_id"],
        nama: json["nama"],
        spesialis: json["spesialis"],
        pengalaman: json["pengalaman"],
        foto: json["foto"],
        harga: json["harga"],
        alumni: json["alumni"],
        lokasiPraktek: json["lokasi_praktek"],
        noStr: json["no_str"],
      );

  Map<String, dynamic> toJson() => {
        "penyedia_id": penyediaId,
        "nama": nama,
        "spesialis": spesialis,
        "foto": foto,
        "pengalaman": pengalaman,
        "harga": harga,
        "alumni": alumni,
        "lokasi_praktek": lokasiPraktek,
        "no_str": noStr,
      };
}
