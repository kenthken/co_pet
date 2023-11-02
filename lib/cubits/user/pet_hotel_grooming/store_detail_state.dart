part of 'store_detail_cubit.dart';

@immutable
sealed class StoreDetailState {}

final class StoreDetailInitial extends StoreDetailState {}

final class StoreDetailLoading extends StoreDetailState {}

final class StoreDetailLoaded extends StoreDetailState {
  final StoreDetailModel data;
  StoreDetailLoaded(this.data);
}

final class StoreDetailError extends StoreDetailState {
  final String message;
  StoreDetailError(this.message);
}
