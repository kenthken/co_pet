part of 'request_list_cubit.dart';

@immutable
sealed class RequestListState {}

final class RequestListInitial extends RequestListState {}

final class RequestListLoading extends RequestListState {}

final class RequestListLoaded extends RequestListState {
  final PetServiceModel? data;
  RequestListLoaded(this.data);
}

final class RequestListError extends RequestListState {
  final String message;
  RequestListError(this.message);
}
