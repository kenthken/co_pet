import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/user/pet_hotel_grooming/store_detail_model.dart';
import 'package:co_pet/domain/repository/user/pet_hotel_grooming/store_detail_repository.dart';
import 'package:meta/meta.dart';

part 'store_detail_state.dart';

class StoreDetailCubit extends Cubit<StoreDetailState> {
  StoreDetailCubit() : super(StoreDetailInitial());

  Future<void> getStoreDetail(int storeId) async {
    try {
      emit(StoreDetailLoading());

      StoreDetailModel data =
          await StoreDetailRepository().getStoreDetail(storeId);

      emit(StoreDetailLoaded(data));
    } catch (e) {
      emit(StoreDetailError(e.toString()));
    }
  }

  Future<void> getStoreDetailPetService(int storeId) async {
    try {
      emit(StoreDetailLoading());

      StoreDetailModel data =
          await StoreDetailRepository().getStoreDetailPetService(storeId);

      emit(StoreDetailLoaded(data));
    } catch (e) {
      emit(StoreDetailError(e.toString()));
    }
  }
}
