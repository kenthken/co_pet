import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/pet-service/admin/pet_service_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AdminRepository {
  Future<PetServiceModel?> getRequestList() async {
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getRequestListAdmin);

      debugPrint("getRequestList() status code: ${response.statusCode}");
      if (response.statusCode == 200) {}
    } catch (e) {
      debugPrint("getRequestList() petservice error = ${e.toString}");
      throw Exception("getRequestList() petservice error = ${e.toString}");
    }
    return null;
  }

  Future<PetServiceModel?> getUserPetService() async {
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getUserPetServiceListAdmin);

      debugPrint("getUserPetService() status code: ${response.statusCode}");
      if (response.statusCode == 200) {}
    } catch (e) {
      debugPrint("getUserPetService() petservice error = ${e.toString}");
      throw Exception("getUserPetService() petservice error = ${e.toString}");
    }
    return null;
  }
}
