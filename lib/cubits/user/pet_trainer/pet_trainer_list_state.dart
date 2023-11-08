part of 'pet_trainer_list_cubit.dart';

@immutable
sealed class PetTrainerListState {}

final class PetTrainerListInitial extends PetTrainerListState {}


final class PetTrainerListLoading extends PetTrainerListState {}

final class PetTrainerListLoaded extends PetTrainerListState {
  final PetTrainerListModel data;
  PetTrainerListLoaded(this.data);
}

final class PetTrainerListError extends PetTrainerListState {
  final String message;
  PetTrainerListError(this.message);
}