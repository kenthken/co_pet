// To parse this JSON data, do
//
//     final TokoRegisterModel = TokoRegisterModelFromJson(jsonString);

import 'dart:convert';

String tokoRegisterModelToJson(TokoRegisterModel data) =>
    json.encode(data.toJson());

class TokoRegisterModel {
  String penyediaId;
  String nama;
  dynamic foto;
  String fasilitas;
  String deskripsi;
  String lokasi;
  String jamBuka;
  String jamTutup;

  TokoRegisterModel({
    required this.penyediaId,
    required this.nama,
    required this.foto,
    required this.fasilitas,
    required this.deskripsi,
    required this.lokasi,
    required this.jamBuka,
    required this.jamTutup,
  });


  Map<String, dynamic> toJson() => {
        "penyedia_id": penyediaId,
        "nama": nama,
        "foto": foto,
        "fasilitas": fasilitas,
        "deskripsi": deskripsi,
        "lokasi": lokasi,
        "jam_buka": jamBuka,
        "jam_tutup": jamTutup,
      };
}
