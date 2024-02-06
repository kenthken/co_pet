import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/pet-service/register/register_toko_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UpdateTokoRepository {
  Future<bool> updateToko(TokoRegisterModel data, String id) async {
    try {
      Response response = await ApiService().putApiData(
          UrlServices.updateToko(id), tokoRegisterModelToJson(data));

      debugPrint("updateToko() status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      debugPrint("updateToko() petservice error = ${e.toString}");
    }
    return false;
  }
}
