import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/user/pet_hotel_grooming/store_list_model.dart';
import 'package:co_pet/domain/repository/user/pet_hotel_grooming/store_list_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'store_list_state.dart';

class StoreListCubit extends Cubit<StoreListState> {
  StoreListCubit() : super(StoreListInitial());
  StoreListRepository storeListRepo = StoreListRepository();

  Future<void> getStoreList(String search) async {
    try {
      emit(StoreListLoading());
      StoreListModel data = await storeListRepo.getStoreList(search);
      debugPrint("masu>");
      emit(StoreListLoaded(data));
    } catch (e) {
      emit(StoreListError(e.toString()));
    }
  }
}
