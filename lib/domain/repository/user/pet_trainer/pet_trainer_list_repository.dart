import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/pet_trainer/pet_trainer_list_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PetTrainerListRepository {
  Future<PetTrainerListModel?> getTrainerList(String freeText) async {
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getTrainerList(freeText));

      if (response.statusCode == 200) {
        debugPrint("getTrainerList Success = ${response.data}");
        return PetTrainerListModel.fromJson(response.data);
      } else {
        throw Exception("getTrainerList() error");
      }
    } catch (e) {
      throw Exception("getTrainerList() error = ${e.toString()}");
    }
  }
}
