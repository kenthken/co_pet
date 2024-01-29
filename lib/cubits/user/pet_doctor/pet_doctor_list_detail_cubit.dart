import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/pet-service/dokter/dokter_detail_model.dart';
import 'package:co_pet/domain/models/user/pet_doctor/pet_doctor_list_detail_model.dart';
import 'package:co_pet/domain/repository/user/pet_doctor/pet_doctor_list_detail_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'pet_doctor_list_detail_state.dart';

class PetDoctorListDetailCubit extends Cubit<PetDoctorListDetailState> {
  PetDoctorListDetailCubit() : super(PetDoctorListDetailInitial());

  Future<void> getDoctorListDetail(String doctorId) async {
    try {
      emit(PetDoctorListDetailLoading());
      DoctorDetailModel? data =
          await PetDoctorListDetailRepository().getDoctorListDetail(doctorId);
      emit(PetDoctorListDetailLoaded(data!));
    } catch (e) {
      debugPrint("eee ${e.toString()}");
      emit(PetDoctorListDetailError(e.toString()));
    }
  }

  //    Future<void> getDoctorDetailPetService(String doctorId) async {
  //   try {
  //     emit(PetDoctorListDetailLoading());
  //     PetDoctorListDetailModel data =
  //         await PetDoctorListDetailRepository().getDoctorListDetail(doctorId);
  //     emit(PetDoctorListDetailLoaded(data));
  //   } catch (e) {
  //     emit(PetDoctorListDetailError(e.toString()));
  //   }
  // }
}
