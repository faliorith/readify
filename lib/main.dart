import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:readify/firebase_options.dart';
import 'package:readify/screens/splash_screen.dart';
import 'package:readify/utils/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:readify/services/notification_service.dart';
import 'package:readify/services/auth_service.dart';
import 'package:readify/blocs/auth/auth_bloc.dart';
import 'package:readify/blocs/theme/theme_bloc.dart';
import 'package:readify/blocs/language/language_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize services
  final notificationService = NotificationService();
  await notificationService.initialize();
  
  final authService = AuthService();
  
  runApp(MyApp(
    notificationService: notificationService,
    authService: authService,
  ));
}

class MyApp extends StatelessWidget {
  final NotificationService notificationService;
  final AuthService authService;

  const MyApp({
    super.key,
    required this.notificationService,
    required this.authService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authService),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => LanguageBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, languageState) {
              return MaterialApp(
                title: 'Readify',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeState.themeMode,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'),
                  Locale('ru'),
                  Locale('kk'),
                ],
                locale: languageState.locale,
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
