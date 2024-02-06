import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/pet-service/admin/pet_service_model.dart';
import 'package:co_pet/domain/models/pet-service/admin/user_pet_service_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AdminRepository {
  Future<PetServiceModel?> getRequestList() async {
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getRequestListAdmin);

      debugPrint("getRequestList() status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("getRequestList() Success: ${response.data}");

        return PetServiceModel.fromJson(response.data);
      }
    } catch (e) {
      debugPrint("getRequestList() petservice error = ${e.toString}");
      throw Exception("getRequestList() petservice error = ${e.toString}");
    }
    return null;
  }

  Future<UserPetServiceModel?> getUserPetService() async {
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getUserPetServiceListAdmin);

      debugPrint("getUserPetService() status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("getUserPetService() Success: ${response.data}");
        return UserPetServiceModel.fromJson(response.data);
      }
    } catch (e) {
      debugPrint("getUserPetService() petservice error = ${e.toString}");
      throw Exception("getUserPetService() petservice error = ${e.toString}");
    }
    return null;
  }

  Future<bool> acceptToko(String tokoId) async {
    try {
      Response response = await ApiService()
          .postApiDataWithoutToken(UrlServices.acceptToko(tokoId), "");

      debugPrint("acceptToko() status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("acceptToko() Success: ${response.data}");
        return true;
      }
    } catch (e) {
      debugPrint("acceptToko() petservice error = ${e.toString}");
      throw Exception("acceptToko() petservice error = ${e.toString}");
    }
    return false;
  }

  Future<bool> acceptDoctor(String doctorId) async {
    try {
      Response response = await ApiService()
          .postApiDataWithoutToken(UrlServices.acceptDokter(doctorId), "");

      debugPrint("acceptDoctor() status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("acceptDoctor() Success: ${response.data}");
        return true;
      }
    } catch (e) {
      debugPrint("acceptDoctor() petservice error = ${e.toString}");
      throw Exception("acceptDoctor() petservice error = ${e.toString}");
    }
    return false;
  }

  Future<bool> acceptTrainer(String trainerId) async {
    try {
      Response response = await ApiService()
          .postApiDataWithoutToken(UrlServices.acceptTrainer(trainerId), "");

      debugPrint("acceptTrainer() status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("acceptTrainer() Success: ${response.data}");
        return true;
      }
    } catch (e) {
      debugPrint("acceptTrainer() petservice error = ${e.toString}");
      throw Exception("acceptTrainer() petservice error = ${e.toString}");
    }
    return false;
  }
}
