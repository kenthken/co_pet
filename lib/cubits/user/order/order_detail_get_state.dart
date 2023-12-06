part of 'order_detail_get_cubit.dart';

@immutable
sealed class OrderDetailGetState {}

final class OrderDetailGetInitial extends OrderDetailGetState {}

final class OrderDetailGetLoading extends OrderDetailGetState {}

final class OrderDetailGetLoaded extends OrderDetailGetState {
  final OrderDetailModel data;
  OrderDetailGetLoaded(this.data);
}

final class OrderDetailGetError extends OrderDetailGetState {
  final String message;
  OrderDetailGetError(this.message);
}