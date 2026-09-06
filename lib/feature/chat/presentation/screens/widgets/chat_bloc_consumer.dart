import 'package:aichatbot/feature/chat/models/chat_message.dart';
import 'package:aichatbot/feature/chat/presentation/cubit/send_message_cubit.dart';
import 'package:aichatbot/feature/chat/presentation/cubit/send_message_state.dart';
import 'package:aichatbot/feature/chat/presentation/screens/widgets/chat_messages_list.dart';
import 'package:aichatbot/feature/chat/presentation/screens/widgets/failure_chat_message_list.dart';
import 'package:aichatbot/feature/chat/presentation/screens/widgets/loading_chat_message_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBlocConsumer extends StatelessWidget {
  final ScrollController scrollController;
  final List<ChatMessageModel> messages;
  const ChatBlocConsumer({
    super.key,
    required this.messages,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendMessageCubit, SendMessageState>(
      listener: (context, state) {
        if (state is SendMessageSuccess) {
          messages.add(state.message);
        }
      },
      builder: (context, state) {
        if (state is SendMessageFailure) {
          return FailureChatMessageList(
            errMessage: state.error,
            onRetry: () {
              context.read<SendMessageCubit>().sendMessage(messages);
            },
            scrollController: scrollController,
            messages: messages,
          );
        } else if (state is SendMessageLoading) {
          return LoadingChatMessageList(
            scrollController: scrollController,
            messages: messages,
          );
        } else {
          return ChatMessagesList(
            messages: messages,
            scrollController: scrollController,
          );
        }
      },
    );
  }
}
