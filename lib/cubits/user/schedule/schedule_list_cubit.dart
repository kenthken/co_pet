import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/schedule/schedule_model.dart';
import 'package:co_pet/domain/repository/schedule/schedule_list_repository.dart';
import 'package:meta/meta.dart';

part 'schedule_list_state.dart';

class ScheduleListCubit extends Cubit<ScheduleListState> {
  ScheduleListCubit() : super(ScheduleListInitial());

  Future<void> getScheduleList() async {
    try {
      emit(ScheduleListLoading());
      ScheduleModel data = await ScheduleListRepository().getScheduleList();
      emit(ScheduleListLoaded(data));
    } catch (e) {
      emit(ScheduleListError(e.toString()));
    }
  }
}
