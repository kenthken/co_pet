import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/user_register_request_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PetServiceRegisterRepository {
  Future<bool> registerPetServiceBE(UserRegisterRequestModel data) async {
    try {
      Response response = await ApiService().postApiDataWithoutToken(
          UrlServices.registerPetService, userRegisterRequestModelToJson(data));
      debugPrint("registerPetServiceBE() status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      debugPrint("registerPetServiceBE() user error = ${e.toString}");
    }
    return false;
  }
}
