import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/user/order/order_detail_get_model.dart';
import 'package:co_pet/domain/repository/user/order/get_order_detail_repository.dart';
import 'package:flutter/material.dart';

part 'order_detail_get_state.dart';

class OrderDetailGetCubit extends Cubit<OrderDetailGetState> {
  OrderDetailGetCubit() : super(OrderDetailGetInitial());

  Future<void> getOrderDetail(String orderId, bool isPetService) async {
    OrderDetailModel response;
    try {
      emit(OrderDetailGetLoading());
      if (isPetService) {
        response =
            await GetOrderDetailRepository().getOrderDetailPetService(orderId);
      } else {
        response = await GetOrderDetailRepository().getOrderDetail(orderId);
      }

      emit(OrderDetailGetLoaded(response));
    } catch (e) {
      emit(OrderDetailGetError(e.toString()));
    }
  }

  Future<void> getOrderDoctorDetail(String orderId, bool isPetService) async {
    OrderDetailModel response;
    try {
      emit(OrderDetailGetLoading());
      if (isPetService) {
        debugPrint("this?");
        response = await GetOrderDetailRepository()
            .getOrderDetailPetServiceDoctor(orderId);
      } else {
        response =
            await GetOrderDetailRepository().getOrderDoctorDetail(orderId);
      }

      emit(OrderDetailGetLoaded(response));
    } catch (e) {
      emit(OrderDetailGetError(e.toString()));
    }
  }

  Future<void> getOrderTrainerDetail(String orderId, bool isPetService) async {
    OrderDetailModel response;

    try {
      emit(OrderDetailGetLoading());
      if (isPetService) {
        response = await GetOrderDetailRepository()
            .getOrderDetailPetServiceTrainer(orderId);
      } else {
        response =
            await GetOrderDetailRepository().getOrderTrainerDetail(orderId);
      }

      emit(OrderDetailGetLoaded(response));
    } catch (e) {
      emit(OrderDetailGetError(e.toString()));
    }
  }
}
