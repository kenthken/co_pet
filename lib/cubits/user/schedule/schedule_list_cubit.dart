import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/user/schedule/schedule_model.dart';
import 'package:co_pet/domain/repository/user/schedule/schedule_list_repository.dart';
import 'package:meta/meta.dart';

part 'schedule_list_state.dart';

class ScheduleListCubit extends Cubit<ScheduleListState> {
  ScheduleListCubit() : super(ScheduleListInitial());

  Future<void> getScheduleList(int userId) async {
    try {
      emit(ScheduleListLoading());
      ScheduleListModel data = await ScheduleListRepository().getScheduleList(userId);
      emit(ScheduleListLoaded(data));
    } catch (e) {
      emit(ScheduleListError(e.toString()));
    }
  }
}
