// To parse this JSON data, do
//
//     final ChatModel = ChatModelFromJson(jsonString);

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  int responseCode;
  String message;
  Data data;

  ChatModel({
    required this.responseCode,
    required this.message,
    required this.data,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
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
  String? roomId;
  String uid;
  int orderId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Data({
    required this.id,
    required this.roomId,
    required this.uid,
    required this.orderId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        roomId: json["room_id"],
        uid: json["uid"],
        orderId: json["order_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "room_id": roomId,
        "uid": uid,
        "order_id": orderId,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}

String startChatModelToJson(StartChatModel data) => json.encode(data.toJson());

class StartChatModel {
  String roomId;
  String orderId;

  StartChatModel({
    required this.roomId,
    required this.orderId,
  });

  factory StartChatModel.fromJson(Map<String, dynamic> json) => StartChatModel(
        roomId: json["room_id"],
        orderId: json["order_id"],
      );

  Map<String, dynamic> toJson() => {
        "room_id": roomId,
        "order_id": orderId,
      };
}
