import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/user_register_request_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class UserRegisterRepository {
  final Dio dio = Dio();

  Future<FirebaseRegisterModel> firebaseUser(
      String email, String password, String username, bool isPetService) async {
        
    FirebaseRegisterModel result =
        FirebaseRegisterModel(success: false, uid: "");

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!isPetService) {
        await FirebaseChatCore.instance.createUserInFirestore(
          types.User(
            firstName: username,
            id: credential.user!.uid, // UID from Firebase Authentication
            imageUrl: '',
            lastName: '',
          ),
        );
      }

      result.success = true;
      result.uid = credential.user!.uid;
      print("User registered successfully!");
      return result;
      // The user has been successfully registered.
    } on FirebaseAuthException catch (error) {
      // Handle any errors that occurred during the registration process.

      result.message = error.code;
      print("Error during user registration: ${error.code}");
    }

    return result;
  }

  // Future<String> registerUser(UserRegisterRequestModel data) async {
  //   String message = "Please try again later";

  //   bool isEmailVerified = await firebaseUser(data.email, data.password);

  //   if (isEmailVerified) {
  //     message = await registerUserBE(data);
  //   }

  //   Fluttertoast.showToast(
  //       msg: message, backgroundColor: Colors.white, textColor: Colors.black);
  //   return message;
  // }

  Future<bool> registerUserBE(UserRegisterRequestModel data) async {
    try {
      Response response = await ApiService().postApiDataWithoutToken(
          UrlServices.registerUrl, userRegisterRequestModelToJson(data));
      debugPrint("register() status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      debugPrint("register() user error = ${e.toString}");
    }
    return false;
  }
}
