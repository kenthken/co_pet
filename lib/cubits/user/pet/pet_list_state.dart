part of 'pet_list_cubit.dart';

@immutable
sealed class PetListState {}

final class PetListInitial extends PetListState {}


final class PetListLoading extends PetListState {}

final class PetListLoaded extends PetListState {
  final GetPetListModel data;
  PetListLoaded(this.data);
}

final class PetListError extends PetListState {
  final String message;
  PetListError(this.message);
}