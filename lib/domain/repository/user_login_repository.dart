import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/utils/secure_storage_services.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserLoginRepository {
  final Dio dio = Dio();
  final SecureStorageService _secureStorageService = SecureStorageService();

  Future<String?> getToken() async {
    return await _secureStorageService.readData("token");
  }

  Future<String?> getEmail() async {
    return await _secureStorageService.readData("email");
  }

  Future<String?> getUsername() async {
    return await _secureStorageService.readData("username");
  }

  Future<String?> getUserId() async {
    return await _secureStorageService.readData("id");
  }

  Future<bool> isTokenEmpty() async {
    final token = await getToken();
    return token == null ? true : false;
  }

  Future<void> saveUserSession(
      String token, String email, String username, int id, String phone) async {
    await _secureStorageService.writeData("phone", phone);
    await _secureStorageService.writeData("token", token);
    await _secureStorageService.writeData("email", email);
    await _secureStorageService.writeData("username", username);
    await _secureStorageService.writeData("id", id.toString());
  }

  Future<void> deleteUserSession() async {
    await _secureStorageService.deleteData("token");
    await _secureStorageService.deleteData("phone");
    await _secureStorageService.deleteData("email");
    await _secureStorageService.deleteData("id");
    await _secureStorageService.deleteData("username");
  }

  Future<String?> login(String email, String pass) async {
    String? token;
    String username;
    int id;
    String phone;

    Map<String, String> insertData = {
      'password': pass,
      'email': email,
    };

    // Simulate delays from API
    await Future.delayed(const Duration(milliseconds: 900));

    try {
      Response response = await ApiService()
          .postApiDataWithoutToken(UrlServices.loginUrl, insertData);

      debugPrint("login() token: ${response.data}");
      if (response.statusCode == 200) {
        token = response.data["refreshToken"];

        username = response.data["data"]["username"];

        id = response.data["data"]["id"];
        phone = response.data["data"]["no_telp"];
        saveUserSession(token!, email, username, id, phone);
      }
    } catch (e) {
      if (e is DioException) {
        print("LoginUser() ${e.toString()}");

        String errorMessage = e.response?.statusCode == null
            ? "Please try again later"
            : e.response?.data["message"];

        Fluttertoast.showToast(
            msg: errorMessage,
            backgroundColor: Colors.white,
            textColor: Colors.black);
        final error =
            "userLogin ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      }
    }
    return token;
  }
}
