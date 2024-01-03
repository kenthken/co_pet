import 'dart:convert';

import 'package:flutter/material.dart';

ScheduleListModel scheduleListModelFromJson(String str) =>
    ScheduleListModel.fromJson(json.decode(str));

String meetingToJson(Meeting data) => json.encode(data.toJson());

class ScheduleListModel {
  int responseCode;
  String message;
  List<Meeting>? data;

  ScheduleListModel({
    required this.responseCode,
    required this.message,
    required this.data,
  });

  factory ScheduleListModel.fromJson(Map<String, dynamic> json) =>
      ScheduleListModel(
        responseCode: json["response_code"],
        message: json["message"],
        data: List<Meeting>.from(json["data"].map((x) => Meeting.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Meeting {
  final int? id;
  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;
  final String startTimeZone;
  final String endTimeZone;
  final String description;
  Meeting(
      {required this.from,
      required this.to,
      this.id,
      this.background = Colors.green,
      this.isAllDay = false,
      this.eventName = '',
      this.startTimeZone = '',
      this.endTimeZone = '',
      this.description = ''});

  factory Meeting.fromJson(Map<String, dynamic> json) {
    String valueString = json["background"].split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    return Meeting(
      id: json["id"],
      eventName: json["nama"],
      from: DateTime.parse(json["mulai_aktivitas"]),
      to: DateTime.parse(json["akhir_aktivitas"]),
      isAllDay: json["isAllDay"],
      background: Color(value),
      description: json["description"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "nama": eventName,
        "hewan_id": 1,
        "tanggal_aktivitas": from.toIso8601String(),
        "mulai_aktivitas": from.toIso8601String(),
        "akhir_aktivitas": to.toIso8601String(),
        "isAllDay": isAllDay,
        "background": background.toString(),
        "description": description,
      };
}
