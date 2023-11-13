import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/activity/history_list_model.dart';
import 'package:co_pet/domain/repository/activity/activity_repository.dart';
import 'package:meta/meta.dart';

part 'history_list_state.dart';

class HistoryListCubit extends Cubit<HistoryListState> {
  HistoryListCubit() : super(HistoryListInitial());

  Future<void> getHistoryList() async {
    try {
      emit(HistoryListLoading());
      HistoryListModel data = await ActivityRepository().getHistoryList();
      emit(HistoryListLoaded(data));
    } catch (e) {
      emit(HistoryListError(e.toString()));
    }
  }
}
