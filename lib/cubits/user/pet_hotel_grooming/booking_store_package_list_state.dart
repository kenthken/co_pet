part of 'booking_store_package_list_cubit.dart';

@immutable
sealed class BookingStoreListState {}

final class BookingStoreListInitial extends BookingStoreListState {}

final class BookingStoreListLoading extends BookingStoreListState {}

final class BookingStoreListLoaded extends BookingStoreListState {
  final BookingStoreListModel data;
  BookingStoreListLoaded(this.data);
}

final class BookingStoreListError extends BookingStoreListState {
  final String message;
  BookingStoreListError(this.message);
}
