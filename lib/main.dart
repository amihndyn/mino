import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mino/pages/home/home_page.dart';
import 'package:mino/pages/splash/splash_screen.dart';
import 'package:provider/provider.dart';

import 'package:mino/screens/pilih.dart';

import 'providers/habit_provider.dart';
import 'providers/journal_provider.dart';
import 'providers/mood_provider.dart';
import 'providers/challenge_provider.dart';
import 'providers/profile_provider.dart';
import 'providers/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HabitProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => JournalProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => MoodProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ChallengeProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        home: SplashScreen(),
      ),
    );
  }
}