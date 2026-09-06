import 'package:aichatbot/core/theme/app_colors.dart';
import 'package:aichatbot/feature/chat/models/chat_message.dart';
import 'package:aichatbot/feature/chat/presentation/cubit/send_message_cubit.dart';
import 'package:aichatbot/feature/chat/presentation/cubit/send_message_state.dart';
import 'package:aichatbot/feature/chat/presentation/screens/widgets/message_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSendMessageCubit extends Mock implements SendMessageCubit {}

void main() {
  late MockSendMessageCubit mockCubit;
  late List<ChatMessageModel> messages;
  late ScrollController scrollController;

  setUp(() {
    mockCubit = MockSendMessageCubit();
    messages = [];
    scrollController = ScrollController();
    
    // Default state
    when(() => mockCubit.state).thenReturn(SendMessageInitial());
    when(() => mockCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  tearDown(() {
    scrollController.dispose();
  });

  Widget createTestWidget({
    required bool isLoading,
    SendMessageState? initialState,
  }) {
    if (initialState != null) {
      when(() => mockCubit.state).thenReturn(initialState);
    }

    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<SendMessageCubit>.value(
          value: mockCubit,
          child: MessageInputField(
            isLoading: isLoading,
            message: messages,
            scrollController: scrollController,
          ),
        ),
      ),
    );
  }

  group('MessageInputField Widget Tests', () {
    testWidgets('Test case 1: Send message successfully', (tester) async {
      // Arrange
      when(() => mockCubit.sendMessage(any())).thenAnswer((_) async {});
      
      await tester.pumpWidget(createTestWidget(isLoading: false));

      // Act - Enter text
      await tester.enterText(find.byType(TextField), 'Hello, AI!');
      await tester.pump();

      // Verify text is entered
      expect(find.text('Hello, AI!'), findsOneWidget);

      // Act - Tap send button
      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pump();

      // Assert
      verify(() => mockCubit.sendMessage(any())).called(1);
      expect(messages.length, 1);
      expect(messages.first.parts.first.text, 'Hello, AI!');
      expect(messages.first.role, 'user');
      
      // Verify text field is cleared
      expect(find.text('Hello, AI!'), findsNothing);
    });

    testWidgets('Test case 2: Send message with loading state - input disabled', 
        (tester) async {
      // Arrange
      await tester.pumpWidget(createTestWidget(isLoading: true));

      // Act - Try to enter text
      final textField = tester.widget<TextField>(find.byType(TextField));

      // Assert
      expect(textField.enabled, false);
      
      // Verify user cannot type
      await tester.enterText(find.byType(TextField), 'Test message');
      await tester.pump();
      
      // The text should not be entered because the field is disabled
      expect(textField.enabled, false);
    });

    testWidgets('Test case 3: Send message failure with retry - retry fails', 
        (tester) async {
      // Arrange - Set initial failure state
      final failureState = SendMessageFailure('Network error');
      when(() => mockCubit.state).thenReturn(failureState);
      
      // Add a failed message to the list
      messages.add(ChatMessageModel.user('First message'));
      messages.add(ChatMessageModel.model('Error occurred'));
      
      when(() => mockCubit.sendMessage(any())).thenAnswer((_) async {});

      await tester.pumpWidget(createTestWidget(
        isLoading: false,
        initialState: failureState,
      ));

      // Act - User retries by sending new message
      await tester.enterText(find.byType(TextField), 'Retry message');
      await tester.pump();

      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pump();

      // Assert - Last failed message should be removed before adding new one
      verify(() => mockCubit.sendMessage(any())).called(1);
      
      // Simulate another failure
      when(() => mockCubit.state).thenReturn(SendMessageFailure('Still failing'));
      await tester.pump();

      // Verify the retry attempt was made
      expect(messages.any((m) => m.parts.first.text == 'Retry message'), true);
    });

    testWidgets('Test case 4: Send message failure with retry - retry succeeds', 
        (tester) async {
      // Arrange - Set initial failure state
      final failureState = SendMessageFailure('Network error');
      when(() => mockCubit.state).thenReturn(failureState);
      
      messages.add(ChatMessageModel.user('First message'));
      
      when(() => mockCubit.sendMessage(any())).thenAnswer((_) async {});

      await tester.pumpWidget(createTestWidget(
        isLoading: false,
        initialState: failureState,
      ));

      // Act - User retries
      await tester.enterText(find.byType(TextField), 'Retry message');
      await tester.pump();

      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pump();

      // Simulate success after retry
      final successState = SendMessageSuccess(
        ChatMessageModel.model('Success response'),
      );
      when(() => mockCubit.state).thenReturn(successState);
      await tester.pump();

      // Assert
      verify(() => mockCubit.sendMessage(any())).called(1);
      expect(messages.any((m) => m.parts.first.text == 'Retry message'), true);
    });

    testWidgets('Test case 5: User sends new message during failure without retry', 
        (tester) async {
      // Arrange - Set initial failure state
      final failureState = SendMessageFailure('Network error');
      when(() => mockCubit.state).thenReturn(failureState);
      
      messages.add(ChatMessageModel.user('First message'));
      
      when(() => mockCubit.sendMessage(any())).thenAnswer((_) async {});

      await tester.pumpWidget(createTestWidget(
        isLoading: false,
        initialState: failureState,
      ));

      final initialMessageCount = messages.length;

      // Act - User doesn't wait and writes a new message
      await tester.enterText(find.byType(TextField), 'New message without waiting');
      await tester.pump();

      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pump();

      // Assert - The failed message should be removed
      expect(messages.length, initialMessageCount); // One removed, one added
      expect(
        messages.last.parts.first.text, 
        'New message without waiting',
      );
      verify(() => mockCubit.sendMessage(any())).called(1);
    });

    testWidgets('Should not send empty message', (tester) async {
      // Arrange
      await tester.pumpWidget(createTestWidget(isLoading: false));

      // Act - Try to send empty message
      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pump();

      // Assert
      verifyNever(() => mockCubit.sendMessage(any()));
      expect(messages.isEmpty, true);
    });

    testWidgets('Should not send message with only whitespace', (tester) async {
      // Arrange
      await tester.pumpWidget(createTestWidget(isLoading: false));

      // Act - Enter only whitespace
      await tester.enterText(find.byType(TextField), '   ');
      await tester.pump();

      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pump();

      // Assert
      verifyNever(() => mockCubit.sendMessage(any()));
      expect(messages.isEmpty, true);
    });

    testWidgets('Should display correct UI elements', (tester) async {
      // Arrange
      await tester.pumpWidget(createTestWidget(isLoading: false));

      // Assert
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.send_rounded), findsOneWidget);
      expect(find.byIcon(Icons.mic_none), findsOneWidget);
      expect(find.text('Write your message'), findsOneWidget);
    });

    testWidgets('Should clear text field after successful send', (tester) async {
      // Arrange
      when(() => mockCubit.sendMessage(any())).thenAnswer((_) async {});
      
      await tester.pumpWidget(createTestWidget(isLoading: false));

      // Act
      await tester.enterText(find.byType(TextField), 'Test message');
      await tester.pump();
      
      expect(find.text('Test message'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pump();

      // Assert - Text field should be cleared
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, isEmpty);
    });
  });
}
