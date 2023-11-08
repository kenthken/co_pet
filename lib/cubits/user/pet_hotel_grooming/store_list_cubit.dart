import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/pet_hotel_grooming/store_list_model.dart';
import 'package:co_pet/domain/repository/pet_hotel_grooming/store_list_repository.dart';
import 'package:meta/meta.dart';

part 'store_list_state.dart';

class StoreListCubit extends Cubit<StoreListState> {
  StoreListCubit() : super(StoreListInitial());
  StoreListRepository storeListRepo = StoreListRepository();
  
  Future<void> getStoreList() async {
    try {
      emit(StoreListLoading());
      StoreListModel data = await storeListRepo.getStoreList();
      emit(StoreListLoaded(data));
    } catch (e) {
      emit(StoreListError(e.toString()));
    }
  }
}
