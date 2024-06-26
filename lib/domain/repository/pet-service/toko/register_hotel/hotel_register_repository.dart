import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/pet-service/toko/register_hotel/hotel_register_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HotelRegisterRepository {
  Future<bool> hotelRegister(HotelRegisterModel data) async {
    try {
      Response response = await ApiService().postApiDataWithoutToken(
          UrlServices.registerHotel, hotelRegisterModelToJson(data));
      debugPrint("hotelRegister() status code: ${response.statusCode}");
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      debugPrint("hotelRegister() petservice error = ${e.toString}");
    }
    return false;
  }

  Future<bool> hotelDelete(String tokoId, String hotelId) async {
    debugPrint("tokoId $tokoId $hotelId");
    try {
      Response response = await ApiService()
          .deleteApiData(UrlServices.deleteHotel(tokoId, hotelId));

      debugPrint("hotelDelete() status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      debugPrint("hotelDelete() petservice error = ${e.toString}");
    }
    return false;
  }
}
