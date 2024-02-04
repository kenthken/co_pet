import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/chat/chat_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatRepository {
  Future<ChatModel?> getChat(String orderId) async {
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getChatDetail(orderId));

      if (response.statusCode == 200) {
        debugPrint("getChat() success ${response.data}");
        return ChatModel.fromJson(response.data);
      }
    } catch (e) {
      print("getChat() error ${e.toString()}");
      throw Exception("getChat() error ${e.toString()}");
    }
  }

  Future<bool> startChat(StartChatModel data) async {
    try {
      Response response = await ApiService().postApiDataWithoutToken(
          UrlServices.updateChatRoomId, startChatModelToJson(data));

      if (response.statusCode == 200) {
        debugPrint("startChat() success ${response.data}");
        return true;
      }
    } catch (e) {
      print("startChat() error ${e.toString()}");
      throw Exception("startChat() error ${e.toString()}");
    }
    return false;
  }
}
