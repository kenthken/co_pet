import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/user/order/order_response_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'order_response_state.dart';

class OrderResponseCubit extends Cubit<OrderResponseState> {
  OrderResponseCubit() : super(OrderResponseInitial());

  // Future<void> getOrderResponse(CreateOrderModel data) async {
  //   try {
  //     emit(OrderResponseLoading());

  //     OrderResponseModel? response =
  //         await CreateOrderRepository().createOrder(data);

  //     // emit(OrderResponseLoaded(response!));
  //   } catch (e) {
  //     emit(OrderResponseError(e.toString()));
  //   }
  // }
}
