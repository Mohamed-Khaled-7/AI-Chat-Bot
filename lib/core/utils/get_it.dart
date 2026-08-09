import 'package:aichatbot/core/services/gemini_chat_service.dart';
import 'package:aichatbot/feature/chat/presentation/cubit/send_message_cubit.dart';
import 'package:aichatbot/feature/chat/repositories/send_message_repository.dart';
import 'package:aichatbot/feature/chat/repositories/send_message_repository_imp.dart';
import 'package:get_it/get_it.dart';

final gitIt = GetIt.instance;
void setup() {
  gitIt.registerFactory<GeminiChatService>(()=> GeminiChatService());
  gitIt.registerLazySingleton<SendMessageRepository>(
    () => (SendMessageRepositoryimpl(service: gitIt())),
  );
  gitIt.registerFactory<SendMessageCubit>(() => SendMessageCubit(repository: gitIt()));

}