import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/pet-service/dokter/dokter_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UpdateDokterRepository {
  Future<bool> updateDokter(DoctorRegisterModel data, String id) async {
    try {
      Response response = await ApiService().putApiData(
          UrlServices.updateDoctor(id), doctorRegisterModelToJson(data));

      debugPrint("updateDokter() status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      debugPrint("updateDokter() petservice error = ${e.toString}");
    }
    return false;
  }
}
