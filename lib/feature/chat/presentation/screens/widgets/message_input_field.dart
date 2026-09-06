import 'package:aichatbot/core/theme/app_colors.dart';
import 'package:aichatbot/feature/chat/models/chat_message.dart';
import 'package:aichatbot/feature/chat/presentation/cubit/send_message_cubit.dart';
import 'package:aichatbot/feature/chat/presentation/cubit/send_message_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageInputField extends StatefulWidget {
  List<ChatMessageModel> message;
  final bool isLoading;
  final ScrollController scrollController;
  MessageInputField({
    required this.isLoading,
    required this.message,
    super.key,
    required this.scrollController,
  });

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  final _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!widget.scrollController.hasClients) return;

      widget.scrollController.animateTo(
        widget.scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _handelSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    if (context.read<SendMessageCubit>().state is SendMessageFailure) {
      widget.message.removeLast();
    }
    widget.message.add(ChatMessageModel.user(text));
    _controller.clear();
    context.read<SendMessageCubit>().sendMessage(widget.message);
    scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.divider, width: 1)),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 6),
        decoration: BoxDecoration(
          color: AppColors.inputFieldColor,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                key: Key('chat_input_bar'),
                enabled: !widget.isLoading,
                textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                enableSuggestions: false,
                autocorrect: false,
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Write your message',
                  hintStyle: TextStyle(color: AppColors.hint, fontSize: 14),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 14, color: AppColors.black),
                maxLines: 1,
              ),
            ),
            Icon(Icons.mic_none, color: AppColors.hint, size: 20),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _handelSend,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.send_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
