import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user_register_request_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserRegisterRepository {
  final Dio dio = Dio();

  Future<String> registerUser(UserRegisterRequestModel data) async {
    String message = "Please try again later";

    try {
      Response response = await ApiService().postApiDataWithoutToken(
          UrlServices.registerUrl, userRegisterRequestModelToJson(data));
      debugPrint("register() status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        message = response.data['message'];
      }
    } catch (e) {
      if (e is DioException) {
        message = e.response?.data["message"];

        e.response?.data['message'] ?? print(e.toString());
      }
    }
    Fluttertoast.showToast(
        msg: message, backgroundColor: Colors.white, textColor: Colors.black);
    return message;
  }
}
