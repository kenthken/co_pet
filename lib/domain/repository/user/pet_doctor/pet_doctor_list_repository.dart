import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/pet_doctor/pet_doctor_list_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PetDoctorListRepository {
  final Dio dio = Dio();

  Future<PetDoctorListModel?> getPetDoctorList(String freeText) async {
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getPetDoctorList(freeText));

      if (response.statusCode == 200) {
        debugPrint("success getPetDoctorList = ${response.data}");
        return PetDoctorListModel.fromJson(response.data);
        // return StoreListModel.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        print("getPetDoctorList() error = ${e.toString()}");
        final error =
            "getPetDoctorList ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("getPetDoctorList() error");
      }
    }
  }
}
