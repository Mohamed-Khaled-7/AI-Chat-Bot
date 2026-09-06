import 'package:aichatbot/core/services/api_client.dart';
import 'package:aichatbot/core/services/gemini_chat_service.dart';
import 'package:aichatbot/feature/chat/presentation/cubit/send_message_cubit.dart';
import 'package:aichatbot/feature/chat/repositories/send_message_repository.dart';
import 'package:aichatbot/feature/chat/repositories/send_message_repository_imp.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

final gitIt = GetIt.instance;

void setup() {
  
  gitIt.registerSingleton<Dio>(Dio());
  gitIt.registerSingleton<ApiClient>( ApiClient(dio: gitIt()));
  gitIt.registerSingleton<GeminiChatService>(
    GeminiChatService(apiClient: gitIt(),api:dotenv.env['GEMINI_API_KEY'] ),
  );
  gitIt.registerSingleton<SendMessageRepository>(
   (SendMessageRepositoryimpl(service: gitIt())),
  );
  gitIt.registerFactory<SendMessageCubit>(
    () => SendMessageCubit(repository: gitIt()),
  );
}
