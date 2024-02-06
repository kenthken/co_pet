import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/pet-service/trainer/register_trainer_model.dart';
import 'package:co_pet/domain/repository/user/user_login_repository.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class TrainerRegisterRepository {
  Future<bool> registerTrainer(TrainerRegisterModel data) async {
    try {
      Response response = await ApiService().postApiDataWithoutToken(
          UrlServices.registerTrainer, trainerRegisterModelToJson(data));

      final credential = await UserLoginRepository().getUserUid();

      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: data.nama,
          id: credential!,
          imageUrl: '',
          lastName: '',
        ),
      );

      debugPrint("registerTrainer() status code: ${response.statusCode}");
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      throw Exception("registerTrainer() user error = ${e.toString}");
    }
    return false;
  }
}
