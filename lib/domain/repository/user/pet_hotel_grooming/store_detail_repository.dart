import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/pet_hotel_grooming/store_detail_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class StoreDetailRepository {
  Future<StoreDetailModel> getStoreDetail(String storeId) async {
    StoreDetailModel data = StoreDetailModel(
        responseCode: 404, message: "getStoreDetail() failed to fetch");
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getStoreDetail(storeId));
      if (response.statusCode == 200) {
        debugPrint("GetStoreListDetail() Success = ${response.data}");

        return StoreDetailModel.fromJson(response.data);
      }
    } catch (e) {
      print("getStoreDetail() error = ${e.toString()}");
      if (e is DioException) {
        print("getStoreDetail() error = ${e.toString()}");
        final error =
            "getStoreDetail ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("getStoreDetail() error");
      }
    }
    return data;
  }

  Future<StoreDetailModel> getStoreDetailPetService(String penyediaId) async {
    StoreDetailModel data = StoreDetailModel(
        responseCode: 404,
        message: "getStoreDetailPetService() failed to fetch");
    try {
      Response response = await ApiService()
          .getApiData(UrlServices.getStoreDetailPetService(penyediaId));
      if (response.statusCode == 200) {
        debugPrint("getStoreDetailPetService()  Success = ${response.data}");

        return StoreDetailModel.fromJson(response.data);
      }
    } catch (e) {
      print("getStoreDetailPetService() error = ${e.toString()}");
      if (e is DioException) {
        print("getStoreDetailPetService() error = ${e.toString()}");
        final error =
            "getStoreDetailPetService ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("getStoreDetailPetService() error");
      }
    }
    return data;
  }
}
