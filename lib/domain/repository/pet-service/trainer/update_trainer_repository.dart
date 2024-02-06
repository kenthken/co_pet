import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/pet-service/trainer/register_trainer_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UpdateTrainerRepository {
  Future<bool> updateTrainer(TrainerRegisterModel data, String id) async {
    try {
      Response response = await ApiService().putApiData(
          UrlServices.updateTrainer(id), trainerRegisterModelToJson(data));

      debugPrint("updateTrainer() status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      debugPrint("updateTrainer() petservice error = ${e.toString}");
    }
    return false;
  }
}
