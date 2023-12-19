import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/activity/history_list_model.dart';
import 'package:co_pet/domain/models/activity/on_going_list_model.dart';
import 'package:co_pet/domain/models/activity/order_list_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ActivityRepository {
  final Dio dio = Dio();

  Future<OrderListModel> getOrderList() async {
    OrderListModel data = OrderListModel(
        responseCode: 404, message: "Get OrderList Error", data: null);
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getOrderList);

      if (response.statusCode == 200) {
        debugPrint("get orderList Successful = ${response.data}");
        data = OrderListModel.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        print("getOrderList() error = ${e.toString()}");
        final error =
            "getOrderList ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("getOrderList() error");
      }
    }
    return data;
  }

  Future<OnGoingListModel> getOnGoingList() async {
    OnGoingListModel data = OnGoingListModel(
        data: null, message: "GetOnGoingList() Error", responseCode: 404);
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getOnGoingList);
      debugPrint("?");
      if (response.statusCode == 200) {
        debugPrint("getOnGoingList() Successful = ${response.data}");
        return OnGoingListModel.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        print("getOnGoingList() error = ${e.toString()}");
        final error =
            "getOnGoingList ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("getOnGoingList() error");
      }
    }
    return data;
  }

  Future<HistoryListModel> getHistoryList() async {
    HistoryListModel data = HistoryListModel(
        data: null, message: "getHistoryList() Error", responseCode: 404);
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getHistoryList);

      if (response.statusCode == 200) {
        return HistoryListModel.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        print("getHistoryList() error = ${e.toString()}");
        final error =
            "getHistoryList ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("getHistoryList() error");
      }
    }
    return data;
  }
}
