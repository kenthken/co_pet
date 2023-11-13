import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/activity/on_going_list_model.dart';
import 'package:co_pet/domain/repository/activity/activity_repository.dart';
import 'package:meta/meta.dart';

part 'on_going_list_state.dart';

class OnGoingListCubit extends Cubit<OnGoingListState> {
  OnGoingListCubit() : super(OnGoingListInitial());

  Future<void> getOnGoingList() async {
    try {
      emit(OnGoingListLoading());
      OnGoingListModel data = await ActivityRepository().getOnGoingList();
      emit(OnGoingListLoaded(data));
    } catch (e) {
      emit(OnGoingListError(e.toString()));
    }
  }
}
