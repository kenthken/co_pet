// To parse this JSON data, do
//
//     final HotelRegisterModel = HotelRegisterModelFromJson(jsonString);

import 'dart:convert';

String hotelRegisterModelToJson(HotelRegisterModel data) =>
    json.encode(data.toJson());

class HotelRegisterModel {
  String tokoId;
  String tipeHotel;
  String fasilitas;
  int harga;

  HotelRegisterModel({
    required this.tokoId,
    required this.tipeHotel,
    required this.fasilitas,
    required this.harga,
  });

  Map<String, dynamic> toJson() => {
        "toko_id": tokoId,
        "tipe_hotel": tipeHotel,
        "fasilitas": fasilitas,
        "harga": harga,
      };
}
