import 'package:aichatbot/core/theme/app_colors.dart';
import 'package:aichatbot/core/utils/get_it.dart';
import 'package:aichatbot/feature/chat/models/chat_message.dart';
import 'package:aichatbot/feature/chat/presentation/cubit/send_message_cubit.dart';
import 'package:aichatbot/feature/chat/presentation/screens/widgets/chat_app_bar.dart';
import 'package:aichatbot/feature/chat/presentation/screens/widgets/chat_bloc_consumer.dart';
import 'package:aichatbot/feature/chat/presentation/screens/widgets/chat_input_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatViewBody extends StatefulWidget {
  const ChatViewBody({super.key});

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  final ScrollController scrollController = ScrollController();

  final List<ChatMessageModel> messages = [];

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const ChatAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocProvider(
                create: (context) => gitIt<SendMessageCubit>(),
                child: ChatBlocConsumer(
                  messages: messages,
                  scrollController: scrollController,
                ),
              ),
            ),
            ChatInputBar(
              messages: messages,
              scrollController: scrollController,
            ),
          ],
        ),
      ),
    );
  }
}
