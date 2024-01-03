import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/schedule/schedule_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ScheduleListRepository {
  final Dio dio = Dio();

  Future<ScheduleListModel> getScheduleList(int userId) async {
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getScheduleList(userId));

      if (response.statusCode == 200) {
        debugPrint("getScheduleList() success ${response.data}");
        return ScheduleListModel.fromJson(response.data);
      } else {
        throw Exception("getScheduleList() error");
      }
    } catch (e) {
      print("getScheduleList() error = ${e.toString()}");
      if (e is DioException) {
        final error =
            "getScheduleList ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("getScheduleList() error");
      }
    }
  }

  Future<bool> createSchedule(int userId, Meeting data) async {
    try {
      Response response = await ApiService().postApiDataWithoutToken(
          UrlServices.createSchedule(userId), meetingToJson(data));

      if (response.statusCode == 201) {
        debugPrint("createSchedule() Success");
        return true;
      }
    } catch (e) {
      debugPrint("createSchedule() error = ${e.toString()}");
    }
    return false;
  }

  Future<bool> updateSchedule(int scheduleId, Meeting data) async {
    try {
      Response response = await ApiService().putApiData(
          UrlServices.updateSchedule(scheduleId), meetingToJson(data));

      if (response.statusCode == 201) {
        debugPrint("updateSchedule() Success");
        return true;
      }
    } catch (e) {
      debugPrint("updateSchedule() error = ${e.toString()}");
    }
    return false;
  }

  Future<bool> deleteSchedule(int scheduleId) async {
    try {
      Response response = await ApiService()
          .deleteApiData(UrlServices.deleteSchedule(scheduleId));

      if (response.statusCode == 201) {
        debugPrint("deleteSchedule() Success");
        return true;
      }
    } catch (e) {
      debugPrint("deleteSchedule() error = ${e.toString()}");
    }
    return false;
  }
}
