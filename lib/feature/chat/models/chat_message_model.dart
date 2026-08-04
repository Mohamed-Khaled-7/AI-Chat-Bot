import 'package:aichatbot/feature/chat/models/chat_part_model.dart';

class ChatMessageModel {
  final List<ChatPartModel> parts;
  final String role;

  ChatMessageModel({required this.parts, required this.role});

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      parts:
          (json['parts'] as List<dynamic>?)
              ?.map((e) => ChatPartModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      role: json['role'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'parts': parts.map((e) => e.toJson()).toList(), 'role': role};
  }
}
