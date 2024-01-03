import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/user/activity/on_going_list_model.dart';
import 'package:co_pet/domain/repository/user/activity/activity_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'on_going_list_state.dart';

class OnGoingListCubit extends Cubit<OnGoingListState> {
  OnGoingListCubit() : super(OnGoingListInitial());

  Future<void> getOnGoingList(String? user) async {
    OnGoingListModel? data;
    try {
      emit(OnGoingListLoading());
      if (user == null) {
        data = await ActivityRepository().getOnGoingList();
        emit(OnGoingListLoaded(data));
      } else if (user == "Toko") {
        data = await ActivityRepository().getOnGoingTokoList();
        emit(OnGoingListPetServiceLoaded(data));
      }
    } catch (e) {
      emit(OnGoingListError(e.toString()));
    }
  }
}
