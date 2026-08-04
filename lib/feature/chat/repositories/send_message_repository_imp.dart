import 'package:aichatbot/feature/chat/repositories/send_message_repository.dart';
import 'package:aichatbot/core/services/gemini_chat_service.dart';
import 'package:aichatbot/feature/chat/models/chat_message_model.dart';

class SendMessageRepositoryimpl implements SendMessageRepository {
  final GeminiChatService _service;

  SendMessageRepositoryimpl({required GeminiChatService service})
    : _service = service;

  @override
  Future<ChatMessageModel> sendMessage(List<ChatMessageModel> messages) async {
    return await _service.sendMessage(messages);
  }
}
