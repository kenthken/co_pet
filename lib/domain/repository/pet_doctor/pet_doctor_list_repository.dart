import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/pet_doctor/pet_doctor_list_model.dart';
import 'package:co_pet/domain/models/pet_hotel_grooming/store_list_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';

class PetDoctorListRepository {
  final Dio dio = Dio();

  Future<PetDoctorListModel> getPetDoctorList(String freeText) async {
    PetDoctorListModel data = PetDoctorListModel();
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getPetDoctorList(freeText));

      if (response.statusCode == 200) {
        // return StoreListModel.fromJson(response.data);
      } else {
        throw Exception("getStoreList() error");
      }
    } catch (e) {
      if (e is DioException) {
        print("getPetDoctorList() error = ${e.toString()}");
        final error =
            "getPetDoctorList ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("getPetDoctorList() error");
      }
    }
    return data;
  }
}
