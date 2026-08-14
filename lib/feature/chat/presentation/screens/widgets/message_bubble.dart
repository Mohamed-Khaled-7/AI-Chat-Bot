import 'package:aichatbot/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isUserMessage;
  

  const MessageBubble({
    super.key,
    required this.text,
    required this.isUserMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (isUserMessage) {
      return _buildUserMessage();
    } else {
      return _buildBotMessage();
    }
  }

  Widget _buildUserMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: const BoxConstraints(
          maxWidth: 300,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.userBubble,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildBotMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 300,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.assistantBubble,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 2, bottom: 12, left: 2),
          child: Icon(Icons.smart_toy, color: AppColors.iconColor, size: 18),
        ),
      ],
    );
  }
}

