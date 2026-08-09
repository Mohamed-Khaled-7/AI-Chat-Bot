import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aichatbot/feature/chat/repositories/send_message_repository.dart';
import 'package:aichatbot/feature/chat/presentation/cubit/send_message_state.dart';
import 'package:aichatbot/feature/chat/models/chat_message.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final SendMessageRepository _repository;

  SendMessageCubit({required SendMessageRepository repository})
      : _repository = repository,
        super(SendMessageInitial());

  Future<void> sendMessage(List<ChatMessageModel> messages) async {
    try {
      emit(SendMessageLoading());
      final message = await _repository.sendMessage(messages);
      emit(SendMessageSuccess(message));
    } catch (e) {
      emit(SendMessageFailure(e.toString()));
    }
  }
}
