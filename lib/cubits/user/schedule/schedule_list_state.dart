part of 'schedule_list_cubit.dart';

@immutable
sealed class ScheduleListState {}

final class ScheduleListInitial extends ScheduleListState {}

final class ScheduleListLoading extends ScheduleListState {}

final class ScheduleListLoaded extends ScheduleListState {
  final ScheduleModel data;
  ScheduleListLoaded(this.data);
}

final class ScheduleListError extends ScheduleListState {
  final String message;
  ScheduleListError(this.message);
}