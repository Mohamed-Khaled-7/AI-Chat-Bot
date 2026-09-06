import 'package:aichatbot/core/const/const.dart';
import 'package:aichatbot/core/services/api_client.dart';
import 'package:aichatbot/feature/chat/models/chat_message.dart';
import 'package:aichatbot/feature/chat/models/message.dart';
import 'package:dio/dio.dart';

class GeminiChatService {
  final ApiClient _apiClient;
  final String? api;
  GeminiChatService({required ApiClient apiClient, required this.api})
    : _apiClient = apiClient;

  static final _url =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-3.6-flash:generateContent';
  static const _model = 'gemini-3.6-flash';

  Future<ChatMessageModel> sendMessage(List<ChatMessageModel> messages) async {
    late Exception exception;
    final requestBody = messages.map((message) => message.toJson()).toList();
    for (int attempt = 0; attempt < 3; attempt++) {
      try {
        final response = await _apiClient.post(
          _url,
          body: {'model': _model, 'contents': requestBody},
          headers: {'x-goog-api-key': api!, 'Content-Type': 'application/json'},
        );
        final geminiResponse = GeminiResponseModel.fromJson(response);
        return geminiResponse.candidates.first.content;
      } on DioException catch (e) {
        exception = e;
        final shouldRetry = _shouldRetry(e);
        if (!shouldRetry || attempt == 3) {
          rethrow;
        }

        if (attempt < 2) {
          await Future.delayed(Duration(seconds: attempt + 1));
        }
      }
    }
    throw exception;
  }

  bool _shouldRetry(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        if (code == null) return false;
        return code == 408 || code == 429 || (code >= 500 && code < 600);
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.unknown:
        return false;
    }
  }
}



// mock ApiClient 


//case 1 succesd from first attempt
//case 2 succesed from second attempt
//case 3 succesed from third attempt
//case 4 failed from all attempts
//case 5 failed from first attempt and don;t retryable 