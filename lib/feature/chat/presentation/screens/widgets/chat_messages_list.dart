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
    if (messages.isEmpty) {
      return const Center(
        child: Text(
          'No messages yet. Start the conversation!',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    } else {
      return ListView.builder(
        reverse: true,
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: messages.length,
        itemBuilder: (context, index) {
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
}
