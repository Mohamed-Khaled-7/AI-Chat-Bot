class ChatPartModel {
  final String text;
  final String? thoughtSignature;

  ChatPartModel({
    required this.text,
    this.thoughtSignature,
  });

  factory ChatPartModel.fromJson(Map<String, dynamic> json) {
    return ChatPartModel(
      text: json['text'] as String? ?? '',
      thoughtSignature: json['thoughtSignature'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'text': text,
    };
    if (thoughtSignature != null) {
      map['thoughtSignature'] = thoughtSignature;
    }
    return map;
  }
}