import 'package:aichatbot/core/const/const.dart';
import 'package:aichatbot/core/services/api_client.dart';
import 'package:aichatbot/feature/chat/models/chat_message.dart';
import 'package:aichatbot/feature/chat/models/message.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiChatService {
  final ApiClient _apiClient;
  GeminiChatService({required ApiClient apiClient}) : _apiClient = apiClient;

  static final _url =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-3.6-flash:generateContent?key=$apiKey';
  static const _model = 'gemini-3.6-flash';

  Future<ChatMessageModel> sendMessage(List<ChatMessageModel> messages) async {
    final requestBody = messages.map((message) => message.toJson()).toList();
    final response = await _apiClient.post(
      _url,
      body: {'model': _model, 'contents': requestBody},
      headers: {
        'x-goog-api-key': dotenv.env['GEMINI_API_KEY']!,
        'Content-Type': 'application/json',
      },
    );
    final geminiResponse = GeminiResponseModel.fromJson(response);
    return geminiResponse.candidates.first.content;
  }

}
