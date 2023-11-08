part of 'pet_doctor_list_cubit.dart';

@immutable
sealed class PetDoctorListState {}

final class PetDoctorListInitial extends PetDoctorListState {}

final class PetDoctorListLoading extends PetDoctorListState {}

final class PetDoctorListLoaded extends PetDoctorListState {
  final PetDoctorListModel data;
  PetDoctorListLoaded(this.data);
}

final class PetDoctorListError extends PetDoctorListState {
  final String message;
  PetDoctorListError(this.message);
}
