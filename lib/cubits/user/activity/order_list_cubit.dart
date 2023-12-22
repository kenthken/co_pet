import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/user/activity/order_list_model.dart';
import 'package:co_pet/domain/repository/user/activity/activity_repository.dart';
import 'package:meta/meta.dart';

part 'order_list_state.dart';

class OrderListCubit extends Cubit<OrderListState> {
  OrderListCubit() : super(OrderListInitial());

  Future<void> getOrderList() async {
    try {
      emit(OrderListLoading());
      OrderListModel data = await ActivityRepository().getOrderList();
      emit(OrderListLoaded(data));
    } catch (e) {
      emit(OrderListError(e.toString()));
    }
  }
}
