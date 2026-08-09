class MessageUiModel {
  final String text;
  final bool isUser;
  final String? time;

  const MessageUiModel({required this.text, required this.isUser, this.time});
}
