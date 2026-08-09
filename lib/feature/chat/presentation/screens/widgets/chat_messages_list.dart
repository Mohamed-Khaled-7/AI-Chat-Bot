import 'package:aichatbot/feature/chat/presentation/screens/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:aichatbot/feature/chat/models/chat_message.dart';

class ChatMessagesList extends StatelessWidget {
  final List<ChatMessageModel> messages;
  final ScrollController scrollController;

  const ChatMessagesList({
    super.key,
    required this.messages,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
  return   ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isUserMessage = message.role == 'user';
        return MessageBubble(
          text: message.parts.first.text,
          isUserMessage: isUserMessage,
        );
      },
    );
    
  }
}
