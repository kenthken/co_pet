part of 'order_response_cubit.dart';

@immutable
sealed class OrderResponseState {}

final class OrderResponseInitial extends OrderResponseState {}

final class OrderResponseLoading extends OrderResponseState {}

final class OrderResponseLoaded extends OrderResponseState {
  final OrderResponseModel data;
  OrderResponseLoaded(this.data);
}

final class OrderResponseError extends OrderResponseState {
  final String message;
  OrderResponseError(this.message);
}
