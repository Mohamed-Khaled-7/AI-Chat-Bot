import 'package:aichatbot/feature/chat/models/chat_message.dart';
import 'package:aichatbot/feature/chat/presentation/screens/widgets/chat_loading_bubble.dart';
import 'package:aichatbot/feature/chat/presentation/screens/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class LoadingChatMessageList extends StatelessWidget {
  final ScrollController scrollController;
  final List<ChatMessageModel> messages;
  const LoadingChatMessageList({
    super.key,
    required this.scrollController,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: messages.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ChatLoadingBubble();
        }
        final message = messages[messages.length - index];
        final isUserMessage = message.role == 'user';
        return MessageBubble(
          text: message.parts.first.text,
          isUserMessage: isUserMessage,
        );
      },
    );
  }
}
