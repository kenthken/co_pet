import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/order/create_order_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateOrderRepository {
  final Dio dio = Dio();

  Future<int> createOrder(CreateOrderModel data) async {
    String message = "Please try again later";

    try {
      Response response = await ApiService().postApiDataWithoutToken(
          UrlServices.createOrder, createOrderModelToJson(data));

      if (response.statusCode == 200) {
        debugPrint("success ${response.data["data"]["order"]["id"]}");
        return response.data["data"]["order"]["id"];
      }
    } catch (e) {
      print("createOrder() error ${e.toString()}");
      if (e is DioException) {
        message = e.response?.data["message"];
        print("message createOrder() error $message");
        e.response?.data['message'] ?? print(e.toString());
        Fluttertoast.showToast(
            msg: message,
            backgroundColor: Colors.white,
            textColor: Colors.black);
      }
    }

    return 0;
  }
}
