# Widget Test Plan: Send Message Feature

## Overview
خطة شاملة لاختبار widget test لميزة إرسال الرسائل في تطبيق AI Chatbot، تشمل جميع الحالات الممكنة والسيناريوهات المختلفة.

## Test Structure
```
test/
  widgets/
    chat_view_body_test.dart       # Main widget tests
    message_input_field_test.dart  # Input field specific tests
```

---

## All Test Cases (Non-Repetitive)

### **Category 1: Initial State**

#### 1.1 Widget Initial Rendering
- **Scenario**: عند فتح الـ widget لأول مرة
- **Expected**:
  - State = `SendMessageInitial`
  - Messages list فارغة
  - TextField enabled
  - يظهر `ChatMessagesList` (empty state)
  - Send button موجود

---

### **Category 2: Input Validation & Behavior**

#### 2.1 Empty Message Prevention
- **Scenario**: المستخدم يضغط send بدون كتابة نص
- **Expected**:
  - لا يتم إرسال الرسالة (line 45-46 في message_input_field.dart)
  - State لا يتغير
  - TextField يبقى enabled

#### 2.2 TextField Disabled During Loading
- **Scenario**: أثناء إرسال رسالة (Loading state)
- **Expected**:
  - `TextField enabled: false` (line 77)
  - المستخدم لا يستطيع الكتابة
  - Send button لا يستجيب

#### 2.3 TextField Cleared After Send
- **Scenario**: بعد الضغط على send بنجاح
- **Expected**:
  - TextEditingController.clear() تم استدعاؤها (line 52)
  - TextField فارغ

---

### **Category 3: State Transitions - Single Message**

#### 3.1 Initial → Loading → Success
- **Scenario**: إرسال رسالة أولى بنجاح
- **Steps**:
  1. Initial state
  2. User types "Hello"
  3. Presses send
  4. Loading state (shows `LoadingChatMessageList` + loading bubble)
  5. Success state
- **Expected**:
  - User message added to list
  - AI response added via listener (line 39-41)
  - يظهر `ChatMessagesList`
  - TextField enabled again

#### 3.2 Initial → Loading → Failure
- **Scenario**: إرسال رسالة أولى تفشل
- **Steps**:
  1. Initial state
  2. User types "Hello"
  3. Presses send
  4. Loading state
  5. Failure state
- **Expected**:
  - يظهر `FailureChatMessageList` (line 47-54)
  - Error message displayed
  - Retry button موجود
  - User message في القائمة
  - TextField enabled again

---

### **Category 4: Loading State Behavior**

#### 4.1 Loading State UI Components
- **Scenario**: أثناء Loading
- **Expected**:
  - `LoadingChatMessageList` widget rendered (line 56-59)
  - `ChatLoadingBubble` في أول العناصر (index 0)
  - جميع الرسائل السابقة معروضة
  - itemCount = messages.length + 1 (line 21 في loading_chat_message_list.dart)

#### 4.2 Multiple Rapid Taps During Loading
- **Scenario**: المستخدم يضغط send عدة مرات بسرعة أثناء loading
- **Expected**:
  - TextField disabled يمنع الإدخال
  - لا تُرسل رسائل إضافية
  - State يبقى Loading

---

### **Category 5: Failure State Behavior**

#### 5.1 Failure State UI Components
- **Scenario**: عند حدوث فشل
- **Expected**:
  - `FailureChatMessageList` widget rendered (line 47-54)
  - `ChatFailureBubble` في أول العناصر (index 0) (line 27-32)
  - Error message معروض
  - Retry button functional
  - Original user message معروض في failure bubble (line 30)

#### 5.2 Retry After Failure → Success
- **Scenario**: المستخدم يضغط retry والرسالة تنجح
- **Steps**:
  1. Failure state
  2. Press retry button
  3. Loading state
  4. Success state
- **Expected**:
  - onRetry callback triggered (line 49-50)
  - sendMessage called with existing messages
  - Success response added to list
  - يظهر `ChatMessagesList`

#### 5.3 Retry After Failure → Failure Again
- **Scenario**: المستخدم يضغط retry والرسالة تفشل مرة أخرى
- **Steps**:
  1. Failure state
  2. Press retry
  3. Loading state
  4. Failure state again
- **Expected**:
  - نفس error message (أو error جديد)
  - Retry button لا يزال موجود
  - User message الأصلية في القائمة

#### 5.4 Send New Message While in Failure State
- **Scenario**: في حالة failure، المستخدم يكتب رسالة جديدة ويرسلها (بدلاً من retry)
- **Steps**:
  1. Failure state (last message failed)
  2. User types new message "Hi again"
  3. Presses send
- **Expected**:
  - `messages.removeLast()` called (line 49 في message_input_field.dart)
  - الرسالة الفاشلة تُحذف من القائمة
  - الرسالة الجديدة تُضاف
  - Loading state
  - Normal flow continues

---

### **Category 6: Multiple Sequential Messages**

#### 6.1 Success → New Message → Success
- **Scenario**: إرسال عدة رسائل متتالية بنجاح
- **Steps**:
  1. Send "Message 1" → Success
  2. Send "Message 2" → Success
  3. Send "Message 3" → Success
- **Expected**:
  - كل رسالة user + AI response في القائمة
  - Messages list length = 6 (3 user + 3 AI)
  - الترتيب صحيح (reverse order في ListView)

#### 6.2 Success → New Message → Failure
- **Scenario**: رسالة ناجحة ثم رسالة فاشلة
- **Steps**:
  1. Send "Message 1" → Success
  2. Send "Message 2" → Failure
- **Expected**:
  - Message 1 + AI response في القائمة
  - Message 2 في القائمة
  - Failure bubble معروض
  - Messages count = 3 (message1, AI response, message2)

---

### **Category 7: BlocListener Behavior**

#### 7.1 Success State Listener
- **Scenario**: عند Success state
- **Expected**:
  - `messages.add(state.message)` called (line 40)
  - AI response added to local messages list
  - UI updates to show new message

#### 7.2 No Listener Action on Loading
- **Scenario**: عند Loading state
- **Expected**:
  - Listener لا يفعل شيء
  - فقط builder يتم استدعاؤه

#### 7.3 No Listener Action on Failure
- **Scenario**: عند Failure state
- **Expected**:
  - Listener لا يفعل شيء
  - فقط builder يتم استدعاؤه

---

### **Category 8: Edge Cases**

#### 8.1 Whitespace-Only Message
- **Scenario**: المستخدم يكتب مسافات فقط
- **Expected**:
  - `text.trim().isEmpty` returns true (line 45)
  - لا يتم إرسال الرسالة
  - TextField يبقى كما هو

#### 8.2 Very Long Message
- **Scenario**: المستخدم يكتب رسالة طويلة جداً
- **Expected**:
  - الرسالة تُرسل بشكل طبيعي
  - No truncation in sending logic
  - (UI truncation handled by MessageBubble widget)

#### 8.3 Message with Special Characters
- **Scenario**: رسالة تحتوي على رموز خاصة (emoji, Arabic, etc.)
- **Expected**:
  - الرسالة تُرسل بشكل طبيعي
  - ChatMessageModel.user(text) يتعامل معها صحيحاً

---

### **Category 9: Widget Lifecycle**

#### 9.1 ScrollController Behavior
- **Scenario**: بعد إرسال رسالة
- **Expected**:
  - `scrollToBottom()` called (line 54)
  - ScrollController.animateTo() executed (line 36-40)
  - Scroll to minScrollExtent (top of reversed list)

#### 9.2 Widget Disposal
- **Scenario**: عند dispose الـ widget
- **Expected**:
  - TextEditingController disposed (line 28)
  - ScrollController disposed (line 27 في chat_view_body.dart)
  - No memory leaks

---

## Test Implementation Details

### Mock Setup Required
```dart
class MockSendMessageRepository extends Mock implements SendMessageRepository {}
class MockScrollController extends Mock implements ScrollController {}
```

### Common Test Helpers
```dart
Widget createTestWidget({
  required SendMessageCubit cubit,
  List<ChatMessageModel>? initialMessages,
}) {
  return MaterialApp(
    home: BlocProvider.value(
      value: cubit,
      child: ChatViewBody(),
    ),
  );
}

void pumpAndSettleWithDelay(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
  await tester.pumpAndSettle();
}
```

### Key Widget Finders
```dart
final textFieldFinder = find.byType(TextField);
final sendButtonFinder = find.byIcon(Icons.send_rounded);
final loadingBubbleFinder = find.byType(ChatLoadingBubble);
final failureBubbleFinder = find.byType(ChatFailureBubble);
final retryButtonFinder = find.text('Retry'); // adjust based on actual UI
final chatMessagesListFinder = find.byType(ChatMessagesList);
final loadingChatMessagesListFinder = find.byType(LoadingChatMessageList);
final failureChatMessagesListFinder = find.byType(FailureChatMessageList);
```

---

## Test Organization

```dart
group('ChatViewBody Widget Tests', () {
  
  group('Initial State', () {
    testWidgets('1.1 Widget Initial Rendering', ...);
  });

  group('Input Validation & Behavior', () {
    testWidgets('2.1 Empty Message Prevention', ...);
    testWidgets('2.2 TextField Disabled During Loading', ...);
    testWidgets('2.3 TextField Cleared After Send', ...);
  });

  group('State Transitions - Single Message', () {
    testWidgets('3.1 Initial → Loading → Success', ...);
    testWidgets('3.2 Initial → Loading → Failure', ...);
  });

  group('Loading State Behavior', () {
    testWidgets('4.1 Loading State UI Components', ...);
    testWidgets('4.2 Multiple Rapid Taps During Loading', ...);
  });

  group('Failure State Behavior', () {
    testWidgets('5.1 Failure State UI Components', ...);
    testWidgets('5.2 Retry After Failure → Success', ...);
    testWidgets('5.3 Retry After Failure → Failure Again', ...);
    testWidgets('5.4 Send New Message While in Failure State', ...);
  });

  group('Multiple Sequential Messages', () {
    testWidgets('6.1 Success → New Message → Success', ...);
    testWidgets('6.2 Success → New Message → Failure', ...);
  });

  group('BlocListener Behavior', () {
    testWidgets('7.1 Success State Listener', ...);
    testWidgets('7.2 No Listener Action on Loading', ...);
    testWidgets('7.3 No Listener Action on Failure', ...);
  });

  group('Edge Cases', () {
    testWidgets('8.1 Whitespace-Only Message', ...);
    testWidgets('8.2 Very Long Message', ...);
    testWidgets('8.3 Message with Special Characters', ...);
  });

  group('Widget Lifecycle', () {
    testWidgets('9.1 ScrollController Behavior', ...);
    testWidgets('9.2 Widget Disposal', ...);
  });
});
```

---

## Summary of All Unique Cases

**Total: 24 Test Cases**

1. Initial rendering
2. Empty message prevention
3. TextField disabled during loading
4. TextField cleared after send
5. Initial → Loading → Success
6. Initial → Loading → Failure
7. Loading state UI components
8. Multiple rapid taps during loading
9. Failure state UI components
10. Retry → Success
11. Retry → Failure again
12. Send new message while in failure (removeLast logic)
13. Multiple success messages sequentially
14. Success → Failure sequence
15. Listener adds message on success
16. Listener no-op on loading
17. Listener no-op on failure
18. Whitespace-only message
19. Very long message
20. Special characters message
21. ScrollController behavior after send
22. Widget disposal cleanup
23. User message added to list on send
24. AI response added from cubit success state

---

## Key Implementation Files Referenced

- `lib/feature/chat/presentation/screens/widgets/chat_veiw_body.dart` (lines 37-81)
- `lib/feature/chat/presentation/screens/widgets/message_input_field.dart` (lines 44-55, 77)
- `lib/feature/chat/presentation/cubit/send_message_cubit.dart` (lines 13-21)
- `lib/feature/chat/presentation/cubit/send_message_state.dart` (all states)
- `lib/feature/chat/presentation/screens/widgets/loading_chat_message_list.dart` (lines 21-32)
- `lib/feature/chat/presentation/screens/widgets/failure_chat_message_list.dart` (lines 27-32)

---

## Critical Logic to Test

### 1. **RemoveLast Logic (line 48-50 in message_input_field.dart)**
```dart
if (context.read<SendMessageCubit>().state is SendMessageFailure) {
  widget.message.removeLast();
}
```
**Test**: Case 5.4 - Send New Message While in Failure State

### 2. **Listener Adding Message (line 39-41 in chat_veiw_body.dart)**
```dart
if (state is SendMessageSuccess) {
  messages.add(state.message);
}
```
**Test**: Case 7.1 - Success State Listener

### 3. **TextField Enabled State (line 77 in message_input_field.dart)**
```dart
enabled: !widget.isLoading,
```
**Test**: Cases 2.2, 4.2

### 4. **Empty Message Check (line 45-46 in message_input_field.dart)**
```dart
if (text.isEmpty) return;
```
**Test**: Cases 2.1, 8.1

---

## Validation Strategy

- Mock `SendMessageRepository` to control success/failure responses
- Use `blocTest` package for cubit state verification
- Use `WidgetTester` for UI interaction
- Verify widget tree using finders
- Verify message list contents and order
- Verify ScrollController behavior with mocks
- Test all state transitions explicitly

---

## Open Questions

None - implementation-ready based on existing codebase.
