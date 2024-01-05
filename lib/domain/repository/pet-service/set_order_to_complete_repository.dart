import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SetOrderToCompleteRepository {
  Future<bool> setOrderToComplete(String orderId) async {
    try {
      Response response = await ApiService()
          .postApiDataWithoutToken(UrlServices.setOrderComplete(orderId), "");
      debugPrint("setOrderToComplete() status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      debugPrint("setOrderToComplete() petservice error = ${e.toString}");
    }
    return false;
  }
}
