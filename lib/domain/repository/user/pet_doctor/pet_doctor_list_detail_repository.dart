import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/pet_doctor/pet_doctor_list_detail_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';

class PetDoctorListDetailRepository {
  final Dio dio = Dio();
  Future<PetDoctorListDetailModel> getDoctorListDetail(String listDoctorId) async {
    PetDoctorListDetailModel data = PetDoctorListDetailModel();
    try {
      Response response =
          await ApiService().getApiData(UrlServices.getDoctorListDetail(listDoctorId));
      if (response.statusCode == 200) {}
    } catch (e) {
      if (e is DioException) {
        print("getDoctorListDetail() error = ${e.toString()}");
        final error =
            "getDoctorListDetail ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("getDoctorListDetail() error");
      }
    }
    return data;
  }
}
