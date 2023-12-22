import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/pet_trainer/pet_trainer_list_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';

class PetTrainerListRepository {
  final Dio dio = Dio();

  Future<PetTrainerListModel> getTrainerList(String freeText) async {
    PetTrainerListModel data = PetTrainerListModel();
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getTrainerList(freeText));

      if (response.statusCode == 200) {
        // return StoreListModel.fromJson(response.data);
      } else {
        throw Exception("getTrainerList() error");
      }
    } catch (e) {
      if (e is DioException) {
        print("getTrainerList() error = ${e.toString()}");
        final error =
            "getTrainerList ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("getTrainerList() error");
      }
    }
    return data;
  }
}
