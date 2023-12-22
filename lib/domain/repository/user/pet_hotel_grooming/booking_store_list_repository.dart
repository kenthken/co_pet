import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/pet_hotel_grooming/booking_store_list_model.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';

class BookingStoreListRepository {
  final Dio dio = Dio();

  Future<BookingStoreListModel> getPackageStoreList(
      int storeId, String service) async {
    BookingStoreListModel data = BookingStoreListModel();
    try {
      Response response = await ApiService()
          .getApiData(UrlServices.getPackageStoreList(storeId, service));
      if (response.statusCode == 200) { 

      }
    } catch (e) {
      
      if (e is DioException) {
        print("getBookingStoreList() error = ${e.toString()}");
        final error =
            "getBookingStoreList ${e.response!.statusCode}: ${e.response!.data["Message"]}";
        throw error;
      } else {
        throw Exception("getBookingStoreList() error");
      }
    }

    return data;
  }
}
