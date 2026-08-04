import 'package:aichatbot/core/services/api_client.dart';
import 'package:aichatbot/feature/chat/models/chat_message_model.dart';

class GeminiChatService {
  final ApiClient _apiClient;
  final String _apiKey;

  GeminiChatService({
    required ApiClient apiClient,
    required String apiKey,
  })  : _apiClient = apiClient,
        _apiKey = apiKey;

  Future<ChatMessageModel> sendMessage(List<ChatMessageModel> messages) async {
    const url = 'https://generativelanguage.googleapis.com/v1beta/interactions';

    final body = {
      'model': 'gemini-3.6-flash',
      'contents': messages.map((m) => m.toJson()).toList(),
    };

    final headers = {
      'x-goog-api-key': _apiKey,
      'Content-Type': 'application/json',
    };

    final response = await _apiClient.post(
      url,
      body: body,
      headers: headers,
    );

    final candidates = response['candidates'] as List<dynamic>?;
    if (candidates != null && candidates.isNotEmpty) {
      final candidate = candidates[0] as Map<String, dynamic>;
      final content = candidate['content'] as Map<String, dynamic>?;
      if (content != null) {
        return ChatMessageModel.fromJson(content);
      }
    }

    throw Exception('Failed to get a valid response from Gemini API');
  }
}
