import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CancelOrderRepository {
  final Dio dio = Dio();

  Future<bool> cancelOrder(int orderId) async {
    try {
      Response response = await ApiService()
          .postApiDataWithoutToken(UrlServices.cancelOrder(orderId), null);

      if (response.statusCode == 200) {
        debugPrint("cancelOrder() success ${response.data["data"]}");
        return true;
      }
    } catch (e) {
      print("cancelOrder() error ${e.toString()}");
      if (e is DioException) {
        Fluttertoast.showToast(
            msg: e.toString(),
            backgroundColor: Colors.white,
            textColor: Colors.black);
      }
    }

    return false;
  }
}
