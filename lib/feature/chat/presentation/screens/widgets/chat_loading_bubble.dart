import 'package:aichatbot/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ChatLoadingBubble extends StatefulWidget {
  const ChatLoadingBubble({super.key});

  @override
  State<ChatLoadingBubble> createState() => _ChatLoadingBubbleState();
}

class _ChatLoadingBubbleState extends State<ChatLoadingBubble>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _dotAnimations;

  static const int _dotCount = 3;
  static const Duration _animationDuration = Duration(milliseconds: 900);
  static const double _dotSpacing = 6.0;
  static const double _dotSize = 6.0;

  @override
  void initState() { 
    super.initState();
    _controller = AnimationController(
      duration: _animationDuration,
      vsync: this,
    )..repeat();

    _dotAnimations = List<Animation<double>>.generate(_dotCount, (index) {
      final double start = index / _dotCount;
      final double end = start + (1 / _dotCount);
      return CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeInOut),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_dotCount, _buildDot),
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return FadeTransition(
      opacity: _dotAnimations[index],
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: _dotSpacing / 2),
        width: _dotSize,
        height: _dotSize,
        decoration: BoxDecoration(
          color: AppColors.iconColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
