import 'package:aichatbot/core/utils/get_it.dart';
import 'package:aichatbot/feature/chat/presentation/cubit/send_message_cubit.dart';
import 'package:aichatbot/feature/chat/repositories/send_message_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSendMessageRepository extends Mock implements SendMessageRepository {}

late MockSendMessageRepository mockSendMessageRepository;
void main() {
  setUp(() async {
    mockSendMessageRepository = MockSendMessageRepository();
    gitIt.reset();
    gitIt.registerSingleton<SendMessageRepository>(mockSendMessageRepository);
    gitIt.registerFactory<SendMessageCubit>(
      () => SendMessageCubit(repository: gitIt<SendMessageRepository>()),
    );
  });

  group(
    "Chat View Body Test Widget", 
    (){
      
    }
    );
}
