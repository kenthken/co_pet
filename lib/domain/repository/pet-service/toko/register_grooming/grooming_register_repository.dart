import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/pet-service/toko/register_grooming/grooming_register_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GroomingRegisterRepository {
  Future<bool> groomingRegister(GroomingRegisterModel data) async {
    try {
      Response response = await ApiService().postApiDataWithoutToken(
          UrlServices.registerGrooming, groomingRegisterModelToJson(data));

      debugPrint("groomingRegister() status code: ${response.statusCode}");
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      debugPrint("groomingRegister() petservice error = ${e.toString}");
    }
    return false;
  }

  Future<bool> groomingDelete(String tokoId, String groomingId) async {
    debugPrint("tokoId $tokoId $groomingId");
    try {
      Response response = await ApiService()
          .deleteApiData(UrlServices.deleteGrooming(tokoId, groomingId));

      debugPrint("groomingDelete() status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      debugPrint("groomingDelete() petservice error = ${e.toString}");
    }
    return false;
  }
}
