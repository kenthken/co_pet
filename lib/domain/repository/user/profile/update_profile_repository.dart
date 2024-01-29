import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/user_register_request_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';

class UpdateUserProfileRepository {
  Future<bool> updateUserProfile(
      String id, UserRegisterRequestModel data) async {
    try {
      Response response = await ApiService().putApiData(
          UrlServices.updateUserProfile(id),
          userRegisterRequestModelToJson(data));

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("updateUserProfile() error");
      }
    } catch (e) {
      print("updateUserProfile() error = ${e.toString()}");
    }
    return false;
  }

  Future<bool> updatePetServiceProfile(
      String id, UserRegisterRequestModel data) async {
    try {
      Response response = await ApiService().putApiData(
          UrlServices.updatePetSerivceProfile(id),
          userRegisterRequestModelToJson(data));

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("updatePetServiceProfile() error");
      }
    } catch (e) {
      print("updatePetServiceProfile() error = ${e.toString()}");
    }
    return false;
  }
}
