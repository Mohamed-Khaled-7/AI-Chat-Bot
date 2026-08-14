import 'package:aichatbot/feature/chat/models/chat_message.dart';
import 'package:aichatbot/feature/chat/presentation/screens/widgets/chat_failure_bubble.dart';
import 'package:aichatbot/feature/chat/presentation/screens/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class FailureChatMessageList extends StatelessWidget {
  final ScrollController scrollController;
  final String errMessage;
  final List<ChatMessageModel> messages;
  final void Function() onRetry;
  const FailureChatMessageList({
    required this.onRetry,
    super.key,
    required this.errMessage,
    required this.scrollController,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ChatFailureBubble(
            onRetry: onRetry,
            originalMessage: messages[messages.length - 1].parts.first.text,
            errorMessage: errMessage,
          );
        }
        final message = messages[messages.length - 1 - index];
        final isUserMessage = message.role == 'user';
        return MessageBubble(
          text: message.parts.first.text,
          isUserMessage: isUserMessage,
        );
      },
    );
  }
}
