import 'package:co_pet/domain/repository/user/user_login_repository.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();
  final UserLoginRepository _userRepository = UserLoginRepository();
  String? token;

  Future<void> _checkToken() async {
    final checkTokenEmpty = await _userRepository.isTokenEmpty();
    if (!checkTokenEmpty) {
      token = await _userRepository.getToken();
    }
  }

  Future<Response<dynamic>> getApiData(String urlServicesName) async {
    await _checkToken();
    Options options = Options(headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    final response = await dio.get(urlServicesName, options: options);
    return response;
  }

  Future<Response<dynamic>> postApiDataWithToken(
      String urlServicesName, Object? modelData) async {
    await _checkToken();
    Options options = Options(headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    final response =
        await dio.post(urlServicesName, options: options, data: modelData);
    return response;
  }

  Future<Response<dynamic>> postApiDataWithoutToken(
      String urlServicesName, Object? modelData) async {
    final response = await dio.post(urlServicesName, data: modelData);

    return response;
  }

  Future<Response<dynamic>> putApiData(
      String urlServicesName, String modelData) async {
    await _checkToken();
    Options options = Options(headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    final response =
        await dio.put(urlServicesName, options: options, data: modelData);
    return response;
  }

  Future<Response<dynamic>> deleteApiData(
      String urlServicesName) async {
    final response = await dio.delete(urlServicesName);
    return response;
  }
}
