// To parse this JSON data, do
//
//     final PetServiceLoginResponseModel = PetServiceLoginResponseModelFromJson(jsonString);

import 'dart:convert';

PetServiceLoginResponseModel petServiceLoginResponseModelFromJson(String str) =>
    PetServiceLoginResponseModel.fromJson(json.decode(str));

class PetServiceLoginResponseModel {
  int code;
  String message;
  Data data;
  String token;
  String refreshToken;

  PetServiceLoginResponseModel({
    required this.code,
    required this.message,
    required this.data,
    required this.token,
    required this.refreshToken,
  });

  factory PetServiceLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      PetServiceLoginResponseModel(
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        token: json["token"],
        refreshToken: json["refreshToken"],
      );
}

class Data {
  int id;
  String email;
  String noTelp;
  String username;
  String? jenisJasa;
  bool isAcc;

  Data({
    required this.id,
    required this.email,
    required this.noTelp,
    required this.username,
    required this.jenisJasa,
    required this.isAcc,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        noTelp: json["no_telp"],
        username: json["username"],
        jenisJasa: json["jenis_jasa"],
        isAcc: json["is_acc"],
      );
}
