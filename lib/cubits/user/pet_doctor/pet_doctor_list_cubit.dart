import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/user/pet_doctor/pet_doctor_list_model.dart';
import 'package:co_pet/domain/repository/user/pet_doctor/pet_doctor_list_repository.dart';
import 'package:meta/meta.dart';

part 'pet_doctor_list_state.dart';

class PetDoctorListCubit extends Cubit<PetDoctorListState> {
  PetDoctorListCubit() : super(PetDoctorListInitial());
  PetDoctorListRepository petDoctorListRepo = PetDoctorListRepository();

  Future<void> getPetDoctorList(String freeText) async {
    try {
      emit(PetDoctorListLoading());
      PetDoctorListModel data =
          await petDoctorListRepo.getPetDoctorList(freeText);
      emit(PetDoctorListLoaded(data));
    } catch (e) {
      emit(PetDoctorListError(e.toString()));
    }
  }
  
}
