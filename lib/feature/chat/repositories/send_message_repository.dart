import 'package:aichatbot/feature/chat/models/chat_message_model.dart';

abstract class SendMessageRepository {
  Future<ChatMessageModel> sendMessage(List<ChatMessageModel> messages);
}
