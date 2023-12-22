// To parse this JSON data, do
//
//     final User = UserFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String message;
    Data data;
    String token;
    String refreshToken;

    User({
        required this.message,
        required this.data,
        required this.token,
        required this.refreshToken,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        message: json["message"],
        data: Data.fromJson(json["data"]),
        token: json["token"],
        refreshToken: json["refreshToken"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
        "token": token,
        "refreshToken": refreshToken,
    };
}

class Data {
    int id;
    String email;
    String noTelp;
    String username;

    Data({
        required this.id,
        required this.email,
        required this.noTelp,
        required this.username,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        noTelp: json["no_telp"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "no_telp": noTelp,
        "username": username,
    };
}
