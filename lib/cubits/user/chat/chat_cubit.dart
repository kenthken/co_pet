import 'package:bloc/bloc.dart';
import 'package:co_pet/domain/models/user/chat/chat_model.dart';
import 'package:co_pet/domain/repository/user/chat/chat_repository.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  Future<void> getChat(String orderId) async {
    try {
      emit(ChatLoading());
      final data = await ChatRepository().getChat(orderId);
      emit(ChatLoaded(data!));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
