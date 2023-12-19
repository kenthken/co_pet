import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/pet_hotel_grooming/booking_store_list_model.dart';
import 'package:co_pet/domain/models/review/create_review_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CreateReviewRepository {
  final Dio dio = Dio();

  Future<void> createReview(CreateReviewModel data) async {
    try {
      Response response = await ApiService().postApiDataWithoutToken(
          UrlServices.createReview, createReviewModelToJson(data));
      debugPrint("response status createReview ${response.statusCode}");
      if (response.statusCode == 201) {
        debugPrint("createReview Success");
      }
    } catch (e) {
      if (e is DioException) {
        print("createReview() error = ${e.toString()}");
        final error =
            "createReview ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("createReview() error");
      }
    }
  }
}
