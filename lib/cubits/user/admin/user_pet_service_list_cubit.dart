import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/pet-service/admin/pet_service_model.dart';
import 'package:co_pet/domain/repository/pet-service/admin/admin_repository.dart';
import 'package:meta/meta.dart';

part 'user_pet_service_list_state.dart';

class UserPetServiceListCubit extends Cubit<UserPetServiceListState> {
  UserPetServiceListCubit() : super(UserPetServiceListInitial());

  Future<void> getUserPetServiceList() async {
    try {
      emit(UserPetServiceListLoading());
      PetServiceModel? data = await AdminRepository().getUserPetService();
      emit(UserPetServiceListLoaded(data));
    } catch (e) {
      emit(UserPetServiceListError(e.toString()));
    }
  }
}
