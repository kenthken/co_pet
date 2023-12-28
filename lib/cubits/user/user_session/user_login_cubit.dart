import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/pet-service/pet_service_login_response_model.dart';
import 'package:co_pet/domain/models/user/user_login_response_model.dart';
import 'package:co_pet/domain/repository/user/user_login_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'user_login_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  final UserLoginRepository userRepository = UserLoginRepository();

  Future<bool> isTokenEmpty() async {
    final bool checkToken = await userRepository.isTokenEmpty();
    print("checktoken $checkToken");
    emit(UserCheckToken(checkToken));
    return checkToken;
  }

  Future<String?> getUserType() async {
    final type = await userRepository.getUserType();
    debugPrint("user type $type");

    return type;
  }

  Future<void> login(String email, String pass, String url) async {
    try {
      emit(UserLoading());

      final userLoaded = await userRepository.login(email, pass, url);

      emit(UserLogin(userLoaded!));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> loginPetService(String email, String pass) async {
    try {
      emit(UserLoading());

      final userLoaded = await userRepository.loginPetService(email, pass);

      emit(PetServiceAccountLoaded(userLoaded!));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
