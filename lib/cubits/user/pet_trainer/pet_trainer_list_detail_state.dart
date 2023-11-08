part of 'pet_trainer_list_detail_cubit.dart';

@immutable
sealed class PetTrainerListDetailState {}

final class PetTrainerListDetailInitial extends PetTrainerListDetailState {}

final class PetTrainerListDetailLoading extends PetTrainerListDetailState {}

final class PetTrainerListDetailLoaded extends PetTrainerListDetailState {
  final PetTrainerListDetailModel data;
  PetTrainerListDetailLoaded(this.data);
}

final class PetTrainerListDetailError extends PetTrainerListDetailState {
  final String message;
  PetTrainerListDetailError(this.message);
}