import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/user/activity/history_list_model.dart';
import 'package:co_pet/domain/repository/user/activity/activity_repository.dart';
import 'package:meta/meta.dart';

part 'history_list_state.dart';

class HistoryListCubit extends Cubit<HistoryListState> {
  HistoryListCubit() : super(HistoryListInitial());

  Future<void> getHistoryList(String? user) async {
    HistoryListModel? data;
    try {
      emit(HistoryListLoading());
      if (user == null) {
        data = await ActivityRepository().getHistoryList();
        emit(HistoryListLoaded(data));
      } else if (user == "Toko") {
        data = await ActivityRepository().getHistoryTokoList();
        emit(HistoryListPetServiceLoaded(data));
      } else if (user == "Dokter" || user == "Trainer") {
        data = await ActivityRepository().getOnCompleteTrainerAndDoctor();
        emit(HistoryListPetServiceLoaded(data));
      }
    } catch (e) {
      emit(HistoryListError(e.toString()));
    }
  }
}
