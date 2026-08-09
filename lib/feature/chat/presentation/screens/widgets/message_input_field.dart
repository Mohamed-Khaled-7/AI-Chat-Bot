import 'package:aichatbot/feature/chat/models/chat_message.dart';
import 'package:aichatbot/feature/chat/presentation/cubit/send_message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageInputField extends StatefulWidget {
  List<ChatMessageModel> message;
   MessageInputField({
    required this.message,
    super.key,
  });

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {

  final _controller=TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }  

  void _handelSend(){
    final text = _controller.text.trim();
    if(text.isEmpty)return;
    widget.message.add(ChatMessageModel.user(text));
    _controller.clear();
    context.read<SendMessageCubit>().sendMessage(widget.message);
    print(widget.message);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Write your message',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 1.5,
                  ),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Icon(
                    Icons.mic_none,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                ),
              ),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap:_handelSend,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
