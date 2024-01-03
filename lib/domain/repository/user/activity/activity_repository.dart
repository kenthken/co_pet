import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/activity/history_list_model.dart';
import 'package:co_pet/domain/models/user/activity/on_going_list_model.dart';
import 'package:co_pet/domain/models/user/activity/order_list_model.dart';
import 'package:co_pet/domain/repository/user/user_login_repository.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ActivityRepository {
  final Dio dio = Dio();

  Future<OrderListModel> getOrderList() async {
    OrderListModel data = OrderListModel(
        responseCode: 404, message: "Get OrderList Error", data: null);
    final userId = await UserLoginRepository().getUserId();
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getOrderList(userId!));

      if (response.statusCode == 200) {
        debugPrint("get orderList Successful = ${response.data}");
        data = OrderListModel.fromJson(response.data);
      }
    } catch (e) {
      print("getOrderList() error = ${e.toString()}");
      if (e is DioException) {
        final error =
            "getOrderList ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("getOrderList() error");
      }
    }
    return data;
  }

  Future<OrderListModel> getOrderTokoList() async {
    OrderListModel data = OrderListModel(
        responseCode: 404, message: "getOrderTokoList Error", data: null);
    final userId = await UserLoginRepository().getUserId();
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getOrderTokoList(userId!));

      if (response.statusCode == 200) {
        debugPrint("get getOrderTokoList Successful = ${response.data}");
        data = OrderListModel.fromJson(response.data);
      }
    } catch (e) {
      print("getOrderTokoList() error = ${e.toString()}");
      if (e is DioException) {
        final error =
            "getOrderTokoList ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("getOrderTokoList() error");
      }
    }
    return data;
  }

  Future<OnGoingListModel> getOnGoingList() async {
    OnGoingListModel data = OnGoingListModel(
        data: null, message: "GetOnGoingList() Error", responseCode: 404);
    final userId = await UserLoginRepository().getUserId();
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getOnGoingList(userId!));
      debugPrint("?");
      if (response.statusCode == 200) {
        debugPrint("getOnGoingList() Successful = ${response.data}");
        return OnGoingListModel.fromJson(response.data);
      }
    } catch (e) {
      print("getOnGoingList() error = ${e.toString()}");
      if (e is DioException) {
        final error =
            "getOnGoingList ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("getOnGoingList() error");
      }
    }
    return data;
  }

  Future<OnGoingListModel> getOnGoingTokoList() async {
    OnGoingListModel data = OnGoingListModel(
        data: null, message: "getOnGoingTokoList() Error", responseCode: 404);
    final userId = await UserLoginRepository().getUserId();
    try {
      Response response = await ApiService()
          .getApiData(UrlServices.getOnGoingTokoList(userId!));
      debugPrint("?");
      if (response.statusCode == 200) {
        debugPrint("getOnGoingTokoList() Successful = ${response.data}");
        return OnGoingListModel.fromJson(response.data);
      }
    } catch (e) {
      print("getOnGoingTokoList() error = ${e.toString()}");
      if (e is DioException) {
        final error =
            "getOnGoingList ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("getOnGoingTokoList() error");
      }
    }
    return data;
  }

  Future<HistoryListModel> getHistoryList() async {
    HistoryListModel data = HistoryListModel(
        data: null, message: "getHistoryList() Error", responseCode: 404);
    final userId = await UserLoginRepository().getUserId();
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getHistoryList(userId!));

      if (response.statusCode == 200) {
        return HistoryListModel.fromJson(response.data);
      }
    } catch (e) {
      print("getHistoryList() error = ${e.toString()}");
      if (e is DioException) {
        final error =
            "getHistoryList ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("getHistoryList() error");
      }
    }
    return data;
  }

  Future<HistoryListModel> getHistoryTokoList() async {
    HistoryListModel data = HistoryListModel(
        data: null, message: "getHistoryTokoList() Error", responseCode: 404);
    final userId = await UserLoginRepository().getUserId();
    try {
      Response response = await ApiService()
          .getApiData(UrlServices.getHistoryTokoList(userId!));

      if (response.statusCode == 200) {
        return HistoryListModel.fromJson(response.data);
      }
    } catch (e) {
      print("getHistoryTokoList() error = ${e.toString()}");
      if (e is DioException) {
        final error =
            "getHistoryTokoList ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("getHistoryTokoList() error");
      }
    }
    return data;
  }
}
