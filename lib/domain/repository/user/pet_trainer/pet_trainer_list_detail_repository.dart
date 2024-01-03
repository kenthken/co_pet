import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/pet_trainer/pet_trainer_list_detail_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';

class PetTrainerListDetailRepository {
   final Dio dio = Dio();
  Future<PetTrainerListDetailModel> getTrainerListDetail(String trainerId) async {
    PetTrainerListDetailModel data = PetTrainerListDetailModel();
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getTrainerListDetail(trainerId));
      if (response.statusCode == 200) {}
    } catch (e) {
      if (e is DioException) {
        print("getTrainerListDetail() error = ${e.toString()}");
        final error =
            "getTrainerListDetail ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("getTrainerListDetail() error");
      }
    }
    return data;
  }
}