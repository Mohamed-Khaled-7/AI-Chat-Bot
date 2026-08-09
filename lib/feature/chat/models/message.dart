import 'package:aichatbot/feature/chat/models/chat_message.dart';

class GeminiResponseModel {
  final List<CandidateModel> candidates;
  final UsageMetadataModel? usageMetadata;
  final String? modelVersion;
  final String? responseId;

  const GeminiResponseModel({
    required this.candidates,
    this.usageMetadata,
    this.modelVersion,
    this.responseId,
  });

  factory GeminiResponseModel.fromJson(Map<String, dynamic> json) {
    return GeminiResponseModel(
      candidates: (json['candidates'] as List<dynamic>? ?? [])
          .map((candidate) => CandidateModel.fromJson(candidate as Map<String, dynamic>))
          .toList(),
      usageMetadata: json['usageMetadata'] != null
          ? UsageMetadataModel.fromJson(json['usageMetadata'] as Map<String, dynamic>)
          : null,
      modelVersion: json['modelVersion'] as String?,
      responseId: json['responseId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'candidates': candidates.map((c) => c.toJson()).toList(),
      if (usageMetadata != null) 'usageMetadata': usageMetadata!.toJson(),
      if (modelVersion != null) 'modelVersion': modelVersion,
      if (responseId != null) 'responseId': responseId,
    };
  }
}

class CandidateModel {
  final ChatMessageModel content;
  final String? finishReason;
  final int? index;

  const CandidateModel({
    required this.content,
    this.finishReason,
    this.index,
  });

  factory CandidateModel.fromJson(Map<String, dynamic> json) {
    return CandidateModel(
      content: ChatMessageModel.fromJson(json['content'] as Map<String, dynamic>),
      finishReason: json['finishReason'] as String?,
      index: json['index'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content.toJson(),
      if (finishReason != null) 'finishReason': finishReason,
      if (index != null) 'index': index,
    };
  }
}

class UsageMetadataModel {
  final int? promptTokenCount;
  final int? candidatesTokenCount;
  final int? totalTokenCount;
  final int? thoughtsTokenCount;

  const UsageMetadataModel({
    this.promptTokenCount,
    this.candidatesTokenCount,
    this.totalTokenCount,
    this.thoughtsTokenCount,
  });

  factory UsageMetadataModel.fromJson(Map<String, dynamic> json) {
    return UsageMetadataModel(
      promptTokenCount: json['promptTokenCount'] as int?,
      candidatesTokenCount: json['candidatesTokenCount'] as int?,
      totalTokenCount: json['totalTokenCount'] as int?,
      thoughtsTokenCount: json['thoughtsTokenCount'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (promptTokenCount != null) 'promptTokenCount': promptTokenCount,
      if (candidatesTokenCount != null) 'candidatesTokenCount': candidatesTokenCount,
      if (totalTokenCount != null) 'totalTokenCount': totalTokenCount,
      if (thoughtsTokenCount != null) 'thoughtsTokenCount': thoughtsTokenCount,
    };
  }
}