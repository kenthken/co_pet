part of 'order_list_cubit.dart';

@immutable
sealed class OrderListState {}

final class OrderListInitial extends OrderListState {}

final class OrderListLoading extends OrderListState {}

final class OrderListLoaded extends OrderListState {
  final OrderListModel? data;
  OrderListLoaded(this.data);
}

final class OrderListPetSerivceLoaded extends OrderListState {
  final OrderListModel? data;
  OrderListPetSerivceLoaded(this.data);
}

final class OrderListError extends OrderListState {
  final String message;
  OrderListError(this.message);
}
