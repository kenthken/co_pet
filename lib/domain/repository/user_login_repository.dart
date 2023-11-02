import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/utils/secure_storage_services.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
      String token, String email, String username, int id) async {
    await _secureStorageService.writeData("token", token);
    await _secureStorageService.writeData("email", email);
    await _secureStorageService.writeData("username", username);
    await _secureStorageService.writeData("id", id.toString());
  }

  Future<String?> login(String email, String pass) async {
    String? token;
    String username;
    int id;

    Map<String, String> insertData = {
      'password': pass,
      'email': email,
    };

    // Simulate delays from API
    await Future.delayed(const Duration(milliseconds: 900));

    try {
      Response response = await ApiService()
          .postApiDataWithoutToken(UrlServices.loginUrl, insertData);

      debugPrint("login() status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data["refreshToken"]);
        }
        token = response.data["refreshToken"];
        username = response.data["data"]["username"];
        email = email;
        id = response.data["data"]["id"];
        await saveUserSession(token!, email, username, id);
      }
    } catch (e) {
      if (e is DioException) {
        print("LoginUser() ${e.toString()}");
        // debugPrint("onCatch Dio Error: ${e.message}");
        // String dioError =
        //     "${e.response?.statusCode}: ${e.response?.data["Message"]}";
        final error =
            "userLogin ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      }
    }
    return token;
  }
}
