import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/pet/pet_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GetPetRepository {
  Future<GetPetListModel?> getPetList(String id) async {
    GetPetListModel? data;

    try {
      Response response =
          await ApiService().getApiData(UrlServices.getPetList(id));

      if (response.statusCode == 200) {
        return GetPetListModel.fromJson(response.data);
      }
    } catch (e) {
      print("getPetList() error ${e.toString()}");
    }

    return data;
  }
}
