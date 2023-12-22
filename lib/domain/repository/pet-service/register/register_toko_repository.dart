import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/pet-service/register/register_toko_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TokoRegisterRepository {
  Future<bool> registerToko(TokoRegisterModel data) async {
    debugPrint("data ${data.jamBuka}");
    try {
      Response response = await ApiService().postApiDataWithoutToken(
          UrlServices.registerToko, tokoRegisterModelToJson(data));
      debugPrint("registerToko() status code: ${response.statusCode}");
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      debugPrint("registerToko() user error = ${e.toString}");
    }
    return false;
  }
}
