import 'package:aichatbot/core/services/gemini_chat_service.dart';
import 'package:aichatbot/feature/chat/models/chat_message.dart';
import 'package:aichatbot/feature/chat/repositories/send_message_repository_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGeminiChatService extends Mock implements GeminiChatService {}

final parts = [const ChatPartModel(text: 'hello')];
const role = 'user';
final ChatMessageModel _getMessageModel = ChatMessageModel(
  parts: parts,
  role: role,
);
void main() {
  late SendMessageRepositoryimpl sendMessageRepositoryimpl;
  late MockGeminiChatService mockGeminiChatService;

  setUp(() {
    mockGeminiChatService = MockGeminiChatService();
    sendMessageRepositoryimpl = SendMessageRepositoryimpl(
      service: mockGeminiChatService,
    );
  });
  group('validation logic in SendMessage', () {
    test(
      "message length doesn't change if length is less than or equal to 20",
      () async {
        List<ChatMessageModel> messages = List.generate(
          20,
          (index) => ChatMessageModel(
            parts: [ChatPartModel(text: 'test')],
            role: 'user',
          ),
        );
        var result =  sendMessageRepositoryimpl.applyChatMesaageHistoryPolicy(messages);
        expect(result.length, equals(messages.length));
      },
    );
    test("message length changes if length is greater than 20", () async {
      when(
        () => mockGeminiChatService.sendMessage(captureAny()),
      ).thenAnswer((_) async => _getMessageModel);
      List<ChatMessageModel> messages = List.generate(
        25,
        (index) => ChatMessageModel(
          parts: [ChatPartModel(text: 'test')],
          role: 'user',
        ),
      );
      await sendMessageRepositoryimpl.sendMessage(messages);
      var newlenth =
          verify(
                () => mockGeminiChatService.sendMessage(captureAny()),
              ).captured.first
              as List<ChatMessageModel>;
      expect(newlenth.length, equals(5));
    });
  });
  
}
