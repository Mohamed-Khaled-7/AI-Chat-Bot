import 'package:aichatbot/feature/chat/models/chat_message.dart';
import 'package:aichatbot/feature/chat/presentation/cubit/send_message_cubit.dart';
import 'package:aichatbot/feature/chat/presentation/cubit/send_message_state.dart';
import 'package:aichatbot/feature/chat/presentation/screens/widgets/chat_app_bar.dart';
import 'package:aichatbot/feature/chat/presentation/screens/widgets/chat_messages_list.dart';
import 'package:aichatbot/feature/chat/presentation/screens/widgets/message_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatViewBody extends StatefulWidget {

  const ChatViewBody({
    super.key,
  });

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
    final ScrollController scrollController=ScrollController();
    final List<ChatMessageModel> messages=[];


 @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ChatAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child:  BlocConsumer<SendMessageCubit, SendMessageState>(
    listener: (context, state) {
     if(state is SendMessageSuccess)
     {
      messages.add(state.message);
     }
     if(state is SendMessageFailure)
     {
      //snack bar
     }
    },
    builder: (context, state) {
      return  ChatMessagesList(
                messages: messages,
                scrollController: scrollController,
              );},),
            ),
            MessageInputField(
              message: messages,
            ),
          ],
        ),
      ),
    );
  }
}
