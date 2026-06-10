import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mino/core/data/datasource/auth_remote_datasource.dart';
import 'package:mino/models/profile_model.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mino/providers/moodjournal_provider.dart';
import 'package:mino/pages/splash/splash_screen.dart';

// Import AuthProvider baru Anda (Arsitektur ideal)
import 'package:mino/providers/auth_provider.dart'; 

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
    ChangeNotifierProvider(create: (_) => HabitProvider()),
    ChangeNotifierProvider(create: (_) => JournalProvider()),
    ChangeNotifierProvider(create: (_) => MoodJournalProvider()),
    ChangeNotifierProvider(create: (_) => MoodProvider()),
    ChangeNotifierProvider(create: (_) => ChallengeProvider()),

    ChangeNotifierProvider(
      create: (_) {
        final provider = ProfileProvider();

        provider.setProfile(
          ProfileModel(
            name: 'Nana',
            email: 'nanana.trkj2028@idn.ac.id',
            avatar: 'assets/images/default.png',
            streak: 0,
            totalHabits: 0,
          ),
        );

        return provider;
      },
    ),

    ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ChangeNotifierProvider(
      create: (_) => AuthProvider(AuthRemoteDatasource()),
    ),
  ],

  child: MaterialApp(
    debugShowCheckedModeBanner: false,

    theme: ThemeData(
      textTheme: GoogleFonts.poppinsTextTheme(),
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),

    home: const SplashScreen(),
      ),
    );
  }
}