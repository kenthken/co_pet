part of 'on_going_list_cubit.dart';

@immutable
sealed class OnGoingListState {}

final class OnGoingListInitial extends OnGoingListState {}

final class OnGoingListLoading extends OnGoingListState {}

final class OnGoingListLoaded extends OnGoingListState {
  final OnGoingListModel? data;
  OnGoingListLoaded(this.data);
}

final class OnGoingListPetServiceLoaded extends OnGoingListState {
  final OnGoingListModel? data;
  OnGoingListPetServiceLoaded(this.data);
}


final class OnGoingListError extends OnGoingListState {
  final String message;
  OnGoingListError(this.message);
}
