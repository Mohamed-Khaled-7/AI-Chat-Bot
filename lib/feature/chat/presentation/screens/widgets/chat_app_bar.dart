import 'package:aichatbot/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.black),
        onPressed: () {},
      ),
      title: Row(
        children: [
          const Icon(Icons.smart_toy, color: AppColors.iconColor, size: 32),
          const SizedBox(width: 8),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ChatGPT',
                style: TextStyle(
                  color: AppColors.titleColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  CircleAvatar(radius: 3, backgroundColor: AppColors.green),
                  SizedBox(width: 6),
                  Text(
                    'Online',
                    style: TextStyle(
                      color: AppColors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.volume_up_outlined, color: AppColors.black),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.ios_share, color: AppColors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
