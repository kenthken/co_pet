import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/pet_hotel_grooming/store_list_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class StoreListRepository {
  final Dio dio = Dio();

  Future<StoreListModel> getStoreList(String search) async {
    StoreListModel data =
        StoreListModel(kode: 404, message: "GetStoreList() failed");
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getStoreList(search));

      if (response.statusCode == 200) {
        debugPrint("GetStoreList() Success = ${response.data}");
        return StoreListModel.fromJson(response.data);
      }
    } catch (e) {
      print("getStoreList() error = ${e.toString()}");
      if (e is DioException) {
        final error =
            "getStoreList ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("getStoreList() error");
      }
    }
    return data;
  }
}
