import 'package:aichatbot/core/utils/get_it.dart';
import 'package:aichatbot/feature/chat/presentation/cubit/send_message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aichatbot/core/shared/app_text_styles.dart';
import 'package:aichatbot/core/theme/app_colors.dart';
import 'package:aichatbot/core/utils/app_router.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => gitIt<SendMessageCubit>(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'AI Chat Bot',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          textTheme: GoogleFonts.poppinsTextTheme(AppTextStyles.textTheme),
          useMaterial3: true,
        ),
        routerConfig: AppRoutes.routes,
      ),
    );
  }
}
