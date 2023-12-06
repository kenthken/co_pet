import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user_register_request_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class UserRegisterRepository {
  final Dio dio = Dio();

  Future<String> registerUser(UserRegisterRequestModel data) async {
    String message = "Please try again later";

    try {
      Response response = await ApiService().postApiDataWithoutToken(
          UrlServices.registerUrl, userRegisterRequestModelToJson(data));
      debugPrint("register() status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        try {
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: data.email,
            password: data.password,
          );

          await FirebaseChatCore.instance.createUserInFirestore(
            types.User(
              firstName: data.nama,
              id: credential.user!.uid, // UID from Firebase Authentication
              imageUrl: '',
              lastName: '',
            ),
          );

          // The user has been successfully registered.
          print("User registered successfully!");
        } catch (error) {
          // Handle any errors that occurred during the registration process.
          print("Error during user registration: $error");
        }

        message = response.data['message'];
      }
    } catch (e) {
      debugPrint("register() user error = ${e.toString}");
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
