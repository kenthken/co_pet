part of 'user_pet_service_list_cubit.dart';

@immutable
sealed class UserPetServiceListState {}

final class UserPetServiceListInitial extends UserPetServiceListState {}

final class UserPetServiceListLoading extends UserPetServiceListState {}

final class UserPetServiceListLoaded extends UserPetServiceListState {
  final UserPetServiceModel? data;
  UserPetServiceListLoaded(this.data);
}

final class UserPetServiceListError extends UserPetServiceListState {
  final String message;
  UserPetServiceListError(this.message);
}
