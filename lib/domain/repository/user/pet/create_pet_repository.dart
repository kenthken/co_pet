import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/pet/pet_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';

class PetRepository {
  Future<bool> createPet(PetModel data) async {
    try {
      Response response = await ApiService().postApiDataWithoutToken(
          UrlServices.createPetUser, petModelToJson(data));

      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      print("createPet() error ${e.toString()}");
    }

    return false;
  }

  Future<bool> deletePet(String userId, String petId) async {
    try {
      Response response = await ApiService()
          .deleteApiData(UrlServices.deletePet(userId, petId));

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print("deletePet() error ${e.toString()}");
    }

    return false;
  }
}
