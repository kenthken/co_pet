import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/utils/secure_storage_services.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<String?> getUserUid() async {
    return await _secureStorageService.readData("uid");
  }

  Future<bool> isTokenEmpty() async {
    final token = await getToken();
    return token == null ? true : false;
  }

  Future<void> saveUserSession(String token, String email, String username,
      int id, String phone, String uid) async {
    await _secureStorageService.writeData("phone", phone);
    await _secureStorageService.writeData("token", token);
    await _secureStorageService.writeData("email", email);
    await _secureStorageService.writeData("username", username);
    await _secureStorageService.writeData("id", id.toString());
    await _secureStorageService.writeData("uid", uid);
  }

  Future<void> deleteUserSession() async {
    await _secureStorageService.deleteData("token");
    await _secureStorageService.deleteData("phone");
    await _secureStorageService.deleteData("email");
    await _secureStorageService.deleteData("id");
    await _secureStorageService.deleteData("username");
    await _secureStorageService.deleteData("uid");
  }

  Future<String?> login(String email, String pass, String url) async {
    String? token;
    String username;
    int id;
    String phone;

    Map<String, String> insertData = {
      'password': pass,
      'email': email,
    };

    try {
      Response response =
          await ApiService().postApiDataWithoutToken(url, insertData);

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );

      debugPrint("login() berhasil token: ${response.data}");
      if (response.statusCode == 200) {
        token = response.data["refreshToken"];
        username = response.data["data"]["username"];
        id = response.data["data"]["id"];
        phone = response.data["data"]["no_telp"];
        debugPrint("sadasdas $token $username $id $phone");
        await saveUserSession(
            token!, email, username, id, phone, credential.user!.uid);
      }
    } catch (e) {
      if (e is DioException) {
        print("LoginUser() error =${e.toString()}");

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
