import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/order/order_detail_get_model.dart';
import 'package:co_pet/domain/repository/user/user_login_repository.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GetOrderDetailRepository {
  final Dio dio = Dio();

  Future<OrderDetailModel> getOrderDetail(int orderId) async {
    String message = "Please try again later";
    final userId = await UserLoginRepository().getUserId();
    OrderDetailModel responseOrderDetail =
        OrderDetailModel(message: message, responseCode: 404, data: null);

    try {
      Response response =
          await ApiService().getApiData(UrlServices.getOrderDetail(
        userId!,
        orderId,
      ));

      if (response.statusCode == 200) {
        debugPrint("getOderDetail() Success = ${response.data}");
        return OrderDetailModel.fromJson(response.data);
      }
    } catch (e) {
      print(" getOderDetail() error ${e.toString()}");
      if (e is DioException) {
        message = e.response?.data["message"];
        print("message getOderDetail() error $message");
        e.response?.data['message'] ?? print(e.toString());
        Fluttertoast.showToast(
            msg: message,
            backgroundColor: Colors.white,
            textColor: Colors.black);
      }
    }

    return responseOrderDetail;
  }
}
