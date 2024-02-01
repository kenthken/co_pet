// To parse this JSON data, do
//
//     final DoctorRegisterModel = DoctorRegisterModelFromJson(jsonString);

import 'dart:convert';

DoctorRegisterModel doctorRegisterModelFromJson(String str) =>
    DoctorRegisterModel.fromJson(json.decode(str));

String doctorRegisterModelToJson(DoctorRegisterModel data) =>
    json.encode(data.toJson());

class DoctorRegisterModel {
  String? penyediaId;
  String nama;
  String spesialis;
  String pengalaman;
  dynamic foto;
  int harga;
  String alumni;
  String lokasiPraktek;
  String noStr;

  DoctorRegisterModel({
    this.penyediaId,
    required this.nama,
    required this.spesialis,
    required this.pengalaman,
    required this.foto,
    required this.harga,
    required this.alumni,
    required this.lokasiPraktek,
    required this.noStr,
  });

  factory DoctorRegisterModel.fromJson(Map<String, dynamic> json) =>
      DoctorRegisterModel(
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
