import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/schedule/schedule_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';

class ScheduleListRepository {
  final Dio dio = Dio();

  Future<ScheduleModel> getScheduleList() async {
    ScheduleModel data = ScheduleModel();
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getScheduleList);

      if (response.statusCode == 200) {
        // return StoreListModel.fromJson(response.data);
      } else {
        throw Exception("getScheduleList() error");
      }
    } catch (e) {
      if (e is DioException) {
        print("getScheduleList() error = ${e.toString()}");
        final error =
            "getScheduleList ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("getScheduleList() error");
      }
    }
    return data;
  }
}
