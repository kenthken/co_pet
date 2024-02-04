import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/user/activity/order_list_model.dart';
import 'package:co_pet/domain/repository/user/activity/activity_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'order_list_state.dart';

class OrderListCubit extends Cubit<OrderListState> {
  OrderListCubit() : super(OrderListInitial());

  Future<void> getOrderList(String? user) async {
    OrderListModel? data;
    debugPrint("user $user");
    try {
      emit(OrderListLoading());
      if (user == null) {
        data = await ActivityRepository().getOrderList();
        emit(OrderListLoaded(data));
      } else if (user == "Toko") {
        data = await ActivityRepository().getOrderTokoList();
        emit(OrderListPetSerivceLoaded(data));
      } else if (user == "Dokter" || user == "Trainer") {
        data = await ActivityRepository().getOrderTrainerAndDoctorList();
        emit(OrderListPetSerivceLoaded(data));
      }
    } catch (e) {
      emit(OrderListError(e.toString()));
    }
  }
}
