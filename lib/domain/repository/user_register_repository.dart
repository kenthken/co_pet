import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user_register_request_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';

class UserRegisterRepository {
  final Dio dio = Dio();

  Future<String> registerUser(UserRegisterRequestModel data) async {
    String message = "Please try again later";

    try {
      Response response = await ApiService().postApiDataWithoutToken(
          UrlServices.registerUrl, userRegisterRequestModelToJson(data));

      if (response.statusCode == 200) {
        message = response.data['message'];
      }
    } catch (e) {
      if (e is DioException) {
        e.response?.data['message'] != null
            ? e.response?.data['message']
            : null;
      }
    }

    return message;
  }
}
