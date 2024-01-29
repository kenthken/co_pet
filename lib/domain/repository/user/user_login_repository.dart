import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/pet-service/pet_service_login_response_model.dart';
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

  Future<String?> getUserType() async {
    return await _secureStorageService.readData("service_type");
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

  Future<void> savePetServiceSession(
      String token,
      String email,
      String username,
      int id,
      String doctorId,
      String trainerId,
      String phone,
      String uid,
      String isAcc,
      String serviceType) async {
    if (doctorId != "") {
      await _secureStorageService.writeData("doctor_id", doctorId);
    } else if (trainerId != "") {
      debugPrint("adawdawd");
      await _secureStorageService.writeData("trainer_id", trainerId);
    }

    await _secureStorageService.writeData("token", token);
    await _secureStorageService.writeData("email", email);
    await _secureStorageService.writeData("username", username);
    await _secureStorageService.writeData("id", id.toString());
    await _secureStorageService.writeData("uid", uid);
    await _secureStorageService.writeData("is_acc", isAcc);
    await _secureStorageService.writeData("service_type", serviceType);
  }

  Future<void> deleteUserSession(bool isPetService) async {
    if (isPetService) {
      await _secureStorageService.deleteData("is_acc");
      await _secureStorageService.deleteData("service_type");
    }

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

      if (response.statusCode == 200) {
        token = response.data["refreshToken"];
        username = response.data["data"]["username"];
        id = response.data["data"]["id"];
        phone = response.data["data"]["no_telp"];

        debugPrint(
            "login() berhasil  ${response.data} uiddd ${credential.user!.uid}");

        await saveUserSession(
            token!, email, username, id, phone, credential.user!.uid);
      }
    } catch (e) {
      print("LoginUser() error =${e.toString()}");

      if (e is DioException) {
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

  Future<PetServiceLoginResponseModel?> loginPetService(
      String email, String pass) async {
    String? token;
    String username;
    int id;
    String phone;
    String isAcc;
    String serviceType;
    PetServiceLoginResponseModel data = PetServiceLoginResponseModel(
        responseCode: 404,
        message: "Please try again later",
        data: null,
        token: null,
        refreshToken: null);
    Map<String, String> insertData = {
      'password': pass,
      'email': email,
    };

    try {
      Response response = await ApiService()
          .postApiDataWithoutToken(UrlServices.loginPetService, insertData);

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );

      if (response.statusCode == 200) {
        token = response.data["refreshToken"];
        username = response.data["data"]["username"];
        id = response.data["data"]["id"];
        phone = response.data["data"]["no_telp"];
        isAcc = response.data["data"]["is_acc"].toString();
        serviceType = response.data["data"]["jenis_jasa"] ?? "";
        String doctorId = response.data["data"]["dokter_id"] != null
            ? response.data["data"]["dokter_id"].toString()
            : "";
        String trainerId = response.data["data"]["trainer_id"] != null
            ? response.data["data"]["trainer_id"].toString()
            : "";

        await savePetServiceSession(token!, email, username, id, doctorId,
            trainerId, phone, credential.user!.uid, isAcc, serviceType);
        debugPrint(
            "login() berhasil  ${response.data} uiddd ${credential.user!.uid}");
        return PetServiceLoginResponseModel.fromJson(response.data);
      }
    } catch (e) {
      print("loginPetService() error =${e.toString()}");
      if (e is DioException) {
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
    return data;
  }
}
