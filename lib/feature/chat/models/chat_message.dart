
class ChatMessageModel {
  final List<ChatPartModel> parts;
  final String role;

  const ChatMessageModel({
    required this.parts,
    required this.role,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      parts: (json['parts'] as List<dynamic>)
          .map((part) => ChatPartModel.fromJson(part as Map<String, dynamic>))
          .toList(),
      role: json['role'] as String,
    );
  }

  factory ChatMessageModel.user(String text) {
    return ChatMessageModel(
      parts: [ChatPartModel(text: text)],
      role: 'user',
    );
  }
  factory ChatMessageModel.model(String text) {
    return ChatMessageModel(
      parts: [ChatPartModel(text: text)],
      role: 'model',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parts': parts.map((part) => part.toJson()).toList(),
      'role': role,
    };
  }

}
class ChatPartModel {
  final String text;
  final String? thoughtSignature;

  const ChatPartModel({
    required this.text,
    this.thoughtSignature,
  });

  factory ChatPartModel.fromJson(Map<String, dynamic> json) {
    return ChatPartModel(
      text: json['text'] as String,
      thoughtSignature: json['thoughtSignature'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      if (thoughtSignature != null) 'thoughtSignature': thoughtSignature,
    };
  }
}