import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/pet_trainer/pet_trainer_list_model.dart';
import 'package:co_pet/domain/repository/pet_trainer/pet_trainer_list_repository.dart';
import 'package:meta/meta.dart';

part 'pet_trainer_list_state.dart';

class PetTrainerListCubit extends Cubit<PetTrainerListState> {
  PetTrainerListCubit() : super(PetTrainerListInitial());

  Future<void> getTrainerList(String freeText) async {
    try {
      emit(PetTrainerListLoading());
      PetTrainerListModel data =
          await PetTrainerListRepository().getTrainerList(freeText);
      emit(PetTrainerListLoaded(data));
    } catch (e) {
      emit(PetTrainerListError(e.toString()));
    }
  }
}
