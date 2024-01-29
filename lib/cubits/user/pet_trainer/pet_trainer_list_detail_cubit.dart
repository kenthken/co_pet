import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/user/pet_trainer/pet_trainer_list_detail_model.dart';
import 'package:co_pet/domain/repository/user/pet_trainer/pet_trainer_list_detail_repository.dart';
import 'package:meta/meta.dart';

part 'pet_trainer_list_detail_state.dart';

class PetTrainerListDetailCubit extends Cubit<PetTrainerListDetailState> {
  PetTrainerListDetailCubit() : super(PetTrainerListDetailInitial());

  Future<void> getTrainerDetail(String trainerId) async {
    try {
      emit(PetTrainerListDetailLoading());
      PetTrainerListDetailModel? data = await PetTrainerListDetailRepository()
          .getTrainerListDetail(trainerId);
      emit(PetTrainerListDetailLoaded(data!));
    } catch (e) {
      emit(PetTrainerListDetailError(e.toString()));
    }
  }
}
