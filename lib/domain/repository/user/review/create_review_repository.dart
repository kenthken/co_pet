import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/review/create_review_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CreateReviewRepository {
  final Dio dio = Dio();

  Future<bool> createReview(CreateReviewModel data) async {
    debugPrint(
        "data ${data.customerId} ${data.serviceType} ${data.orderId} ${data.rating} ${data.ulasan}");

    Object? tojson;

    if (data.serviceType.toLowerCase() == "grooming" ||
        data.serviceType.toLowerCase() == "hotel") {
      tojson = createReviewTokoModelToJson(data);
    } else if (data.serviceType.toLowerCase() == "dokter") {
      tojson = createReviewDokterModelToJson(data);
    } else if (data.serviceType.toLowerCase() == "trainer") {
      tojson = createReviewTrainerModelToJson(data);
    }

    try {
      Response response = await ApiService()
          .postApiDataWithoutToken(UrlServices.createReview, tojson);
      debugPrint("response status createReview ${response.statusCode}");
      if (response.statusCode == 201) {
        debugPrint("createReview Success");
        return true;
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
    return false;
  }
}
