import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/pet-service/admin/pet_service_model.dart';
import 'package:co_pet/domain/repository/pet-service/admin/admin_repository.dart';
import 'package:meta/meta.dart';

part 'request_list_state.dart';

class RequestListCubit extends Cubit<RequestListState> {
  RequestListCubit() : super(RequestListInitial());

  Future<void> getRequestList() async {
    try {
      emit(RequestListLoading());
      PetServiceModel? data = await AdminRepository().getRequestList();
      emit(RequestListLoaded(data));
    } catch (e) {
      emit(RequestListError(e.toString()));
    }
  }
}
