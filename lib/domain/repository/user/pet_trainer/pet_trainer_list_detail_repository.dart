import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/pet_trainer/pet_trainer_list_detail_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PetTrainerListDetailRepository {
  final Dio dio = Dio();
  Future<PetTrainerListDetailModel?> getTrainerListDetail(
      String trainerId) async {
    try {
      debugPrint("adawd $trainerId");
      Response response = await ApiService()
          .getApiData(UrlServices.getTrainerListDetail(trainerId));
      if (response.statusCode == 200) {
        debugPrint("getTrainerListDetail() success = ${response.data}");
        return PetTrainerListDetailModel.fromJson(response.data);
      }
    } catch (e) {
      print("getTrainerListDetail() error = ${e.toString()}");
      throw Exception("getTrainerListDetail() error = ${e.toString()}");
    }
    return null;
  }
}
