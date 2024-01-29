import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/user/pet/pet_model.dart';
import 'package:co_pet/domain/repository/user/pet/get_pet_repository.dart';
import 'package:meta/meta.dart';

part 'pet_list_state.dart';

class PetListCubit extends Cubit<PetListState> {
  PetListCubit() : super(PetListInitial());

  Future<void> getPetList(String id) async {
    try {
      emit(PetListLoading());
      final data = await GetPetRepository().getPetList(id);
      emit(PetListLoaded(data!));
    } catch (e) {
      emit(PetListError(e.toString()));
    }
  }
}
