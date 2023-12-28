part of 'user_login_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final User user;
  UserLoaded(this.user);
}

final class UserLogin extends UserState {
  final String token;
  UserLogin(this.token);
}

final class UserError extends UserState {
  final String message;
  UserError(this.message);
}

class UserCheckToken extends UserState {
  final bool isTokenEmpty;

  UserCheckToken(this.isTokenEmpty);
}

class UserType extends UserState {
  final String? type;
  UserType(this.type);
}

class PetServiceAccountLoaded extends UserState {
  final PetServiceLoginResponseModel data;
  PetServiceAccountLoaded(this.data);
}
