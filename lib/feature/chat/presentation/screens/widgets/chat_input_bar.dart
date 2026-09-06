import 'package:aichatbot/feature/chat/models/chat_message.dart';
import 'package:aichatbot/feature/chat/presentation/cubit/send_message_cubit.dart';
import 'package:aichatbot/feature/chat/presentation/cubit/send_message_state.dart';
import 'package:aichatbot/feature/chat/presentation/screens/widgets/message_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({
    super.key,
    required this.messages,
    required this.scrollController,
  });

  
  final List<ChatMessageModel> messages;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocSelector<SendMessageCubit, SendMessageState, bool>(
          selector: (state) {
            return state is SendMessageLoading;
          },
          builder: (context, isLoading) {
            return MessageInputField(
              isLoading: isLoading,
              message: messages,
              scrollController: scrollController,
            );
          },
        ),
      ],
    );
  }
}
