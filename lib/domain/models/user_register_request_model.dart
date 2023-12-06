// To parse this JSON data, do
//
//     final UserRegisterRequestModel = UserRegisterRequestModelFromJson(jsonString);

import 'dart:convert';

String userRegisterRequestModelToJson(UserRegisterRequestModel data) =>
    json.encode(data.toJson());

class UserRegisterRequestModel {
  String nama;
  String email;
  String noTelp;
  String gender;
  String password;

  UserRegisterRequestModel({
    required this.nama,
    required this.email,
    required this.noTelp,
    required this.gender,
    required this.password,
  });

  factory UserRegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      UserRegisterRequestModel(
        nama: json["nama"],
        email: json["email"],
        noTelp: json["no_telp"],
        gender: json["gender"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "email": email,
        "no_telp": noTelp,
        "gender": gender,
        "password": password,
      };
}
