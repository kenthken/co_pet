part of 'history_list_cubit.dart';

@immutable
sealed class HistoryListState {}

final class HistoryListInitial extends HistoryListState {}

final class HistoryListLoading extends HistoryListState {}

final class HistoryListLoaded extends HistoryListState {
  final HistoryListModel data;
  HistoryListLoaded(this.data);
}

final class HistoryListError extends HistoryListState {
  final String message;
  HistoryListError(this.message);
}