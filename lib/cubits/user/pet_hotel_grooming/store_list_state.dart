part of 'store_list_cubit.dart';

@immutable
sealed class StoreListState {}

final class StoreListInitial extends StoreListState {}

final class StoreListLoading extends StoreListState {}

final class StoreListLoaded extends StoreListState {
  final StoreListModel data;
  StoreListLoaded(this.data);
}

final class StoreListError extends StoreListState {
  final String message;
  StoreListError(this.message);
}
