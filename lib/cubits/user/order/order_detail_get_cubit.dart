import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/user/order/order_detail_get_model.dart';
import 'package:co_pet/domain/repository/user/order/get_order_detail_repository.dart';
import 'package:meta/meta.dart';

part 'order_detail_get_state.dart';

class OrderDetailGetCubit extends Cubit<OrderDetailGetState> {
  OrderDetailGetCubit() : super(OrderDetailGetInitial());

  Future<void> getOrderDetail(int orderId) async {
    try {
      emit(OrderDetailGetLoading());

      OrderDetailModel response =
          await GetOrderDetailRepository().getOrderDetail(orderId);

      emit(OrderDetailGetLoaded(response));
    } catch (e) {
      emit(OrderDetailGetError(e.toString()));
    }
  }
}
