import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/pet-service/dokter/dokter_detail_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PetDoctorListDetailRepository {
  final Dio dio = Dio();
  Future<DoctorDetailModel?> getDoctorListDetail(String listDoctorId) async {
    try {
      Response response = await ApiService()
          .getApiData(UrlServices.getDoctorListDetail(listDoctorId));
      if (response.statusCode == 200) {
        debugPrint("Success getDoctorListDetail = ${response.data}");
        return DoctorDetailModel.fromJson(response.data);
      }
    } catch (e) {
      throw Exception("getDoctorListDetail() error = ${e.toString()}");
    }
    return null;
  }
}
