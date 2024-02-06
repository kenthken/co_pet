import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/pet-service/admin/pet_service_model.dart';
import 'package:co_pet/domain/models/pet-service/admin/user_pet_service_model.dart';
import 'package:co_pet/domain/repository/pet-service/admin/admin_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'user_pet_service_list_state.dart';

class UserPetServiceListCubit extends Cubit<UserPetServiceListState> {
  UserPetServiceListCubit() : super(UserPetServiceListInitial());

  Future<void> getUserPetServiceList() async {
    try {
      emit(UserPetServiceListLoading());
      UserPetServiceModel? data = await AdminRepository().getUserPetService();
      emit(UserPetServiceListLoaded(data));
    } catch (e) {
      debugPrint(e.toString());
      emit(UserPetServiceListError(e.toString()));
    }
  }
}
