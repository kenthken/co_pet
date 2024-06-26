import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/pet-service/dokter/dokter_model.dart';
import 'package:co_pet/domain/repository/user/user_login_repository.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class DokterRegisterRepository {
  Future<bool> registerDokter(DoctorRegisterModel data) async {
    try {
      Response response = await ApiService().postApiDataWithoutToken(
          UrlServices.registerDoctor, doctorRegisterModelToJson(data));

      final credential = await UserLoginRepository().getUserUid();

      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: data.nama,
          id: credential!,
          imageUrl: '',
          lastName: '',
        ),
      );

      debugPrint("registerDokter() status code: ${response.statusCode}");
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      throw Exception("registerDokter() user error = ${e.toString}");
    }
    return false;
  }
}
