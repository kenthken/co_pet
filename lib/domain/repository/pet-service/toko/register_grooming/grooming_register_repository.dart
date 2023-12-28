import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/pet-service/toko/register_grooming/grooming_register_model.dart';
import 'package:co_pet/domain/models/pet-service/toko/register_hotel/hotel_register_model.dart';
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
}
