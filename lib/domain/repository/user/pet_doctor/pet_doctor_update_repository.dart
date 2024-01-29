import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/pet_doctor/pet_doctor_list_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PetDoctorUpdateRepository {
  final Dio dio = Dio();

  Future<bool> updateStatus(String id) async {
    try {
      Response response =
          await ApiService().putApiData(UrlServices.updateDoctorStatus(id), "");

      if (response.statusCode == 200) {
        debugPrint("success updateStatus = ${response.data}");
        return true;
      }
    } catch (e) {
      throw Exception("updateStatus() error = ${e.toString()}");
    }
    return false;
  }
}
