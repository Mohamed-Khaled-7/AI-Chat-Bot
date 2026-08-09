import 'package:aichatbot/feature/chat/presentation/screens/chat_view.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  AppRoutes._();

  static final chatRoute = '/ChatView';

  static final routes = GoRouter(
    initialLocation: AppRoutes.chatRoute,
    routes: [
      GoRoute(
        path: AppRoutes.chatRoute,
        builder: (context, state) => const ChatView(),
      ),
    ],
  );
}
