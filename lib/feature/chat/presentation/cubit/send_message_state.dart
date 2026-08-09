import 'package:aichatbot/feature/chat/models/chat_message.dart';

abstract class SendMessageState {}

class SendMessageInitial extends SendMessageState {}

class SendMessageLoading extends SendMessageState {}

class SendMessageSuccess extends SendMessageState {
  final ChatMessageModel message;
  SendMessageSuccess(this.message);
}

class SendMessageFailure extends SendMessageState {
  final String error;
  SendMessageFailure(this.error);
}
