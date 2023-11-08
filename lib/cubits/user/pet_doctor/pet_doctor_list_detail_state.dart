part of 'pet_doctor_list_detail_cubit.dart';

@immutable
sealed class PetDoctorListDetailState {}

final class PetDoctorListDetailInitial extends PetDoctorListDetailState {}

final class PetDoctorListDetailLoading extends PetDoctorListDetailState {}

final class PetDoctorListDetailLoaded extends PetDoctorListDetailState {
  final PetDoctorListDetailModel data;
  PetDoctorListDetailLoaded(this.data);
}

final class PetDoctorListDetailError extends PetDoctorListDetailState {
  final String message;
  PetDoctorListDetailError(this.message);
}