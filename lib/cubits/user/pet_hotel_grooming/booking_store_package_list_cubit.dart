import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/pet_hotel_grooming/booking_store_list_model.dart';
import 'package:co_pet/domain/repository/pet_hotel_grooming/booking_store_list_repository.dart';
import 'package:meta/meta.dart';

part 'booking_store_package_list_state.dart';

class BookingStoreListCubit extends Cubit<BookingStoreListState> {
  BookingStoreListCubit() : super(BookingStoreListInitial());

  Future<void> getPackageStoreList(int storeId, String service) async {
    try {
      emit(BookingStoreListLoading());
      BookingStoreListModel data = await BookingStoreListRepository()
          .getPackageStoreList(storeId, service);
      emit(BookingStoreListLoaded(data));
    } catch (e) {
      emit(BookingStoreListError(e.toString()));
    }
  }
}
