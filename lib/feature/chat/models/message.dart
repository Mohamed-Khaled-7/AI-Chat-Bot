import 'package:aichatbot/feature/chat/models/chat_message.dart';

class GeminiResponseModel {
  final List<CandidateModel> candidates;

  const GeminiResponseModel({required this.candidates});

  factory GeminiResponseModel.fromJson(Map<String, dynamic> json) {
    return GeminiResponseModel(
      candidates: (json['candidates'] as List<dynamic>? ?? [])
          .map(
            (candidate) =>
                CandidateModel.fromJson(candidate as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'candidates': candidates.map((c) => c.toJson()).toList()};
  }
}

class CandidateModel {
const CandidateModel({required this.content});
final ChatMessageModel content;
  factory CandidateModel.fromJson(Map<String, dynamic> json) {
    return CandidateModel(
      content: ChatMessageModel.fromJson(
        json['content'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'content': content.toJson()};
  }
}
