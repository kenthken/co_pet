import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/pet_hotel_grooming/store_detail_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class StoreDetailRepository {
  final Dio dio = Dio();
  Future<StoreDetailModel> getStoreDetail(int storeId) async {
    StoreDetailModel data = StoreDetailModel(
        kode: 404, message: "getStoreDetail() failed to fetch");
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getStoreDetail(storeId));
      if (response.statusCode == 200) {
        debugPrint("GetStoreListDetail() Success = ${response.data}");

        return StoreDetailModel.fromJson(response.data);
      }
    } catch (e) {
      print("lalala ${e.toString()}");
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
}
