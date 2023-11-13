import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/activity/history_list_model.dart';
import 'package:co_pet/domain/models/activity/on_going_list_model.dart';
import 'package:co_pet/domain/models/activity/order_list_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';

class ActivityRepository {
  final Dio dio = Dio();

  Future<OrderListModel> getOrderList() async {
    OrderListModel data = OrderListModel();
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getOrderList);

      if (response.statusCode == 200) {}
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
    OnGoingListModel data = OnGoingListModel();
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getOnGoingList);

      if (response.statusCode == 200) {}
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
    HistoryListModel data = HistoryListModel();
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getHistoryList);

      if (response.statusCode == 200) {}
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
