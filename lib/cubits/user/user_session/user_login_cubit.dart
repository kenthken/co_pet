import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/user_login_response_model.dart';
import 'package:co_pet/domain/repository/user_login_repository.dart';
import 'package:meta/meta.dart';

part 'user_login_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  final UserLoginRepository userRepository = UserLoginRepository();

  Future<void> isTokenEmpty() async {
    final bool checkToken = await userRepository.isTokenEmpty();
    emit(UserCheckToken(checkToken));
  }

  Future<void> login(String email, String pass) async {
    try {
      emit(UserLoading());

      final userLoaded = await userRepository.login(email, pass);
      emit(UserLogin(userLoaded!));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
