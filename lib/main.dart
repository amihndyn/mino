import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mino/core/data/datasource/auth_remote_datasource.dart';
import 'package:mino/core/data/datasource/dashboard_remote_datasource.dart';
import 'package:mino/core/data/repositories/dashboard_repository.dart';
import 'package:mino/core/presentation/home/bloc/focus_timer/focus_timer_bloc.dart';
import 'package:mino/pages/auth/login_page.dart';
import 'package:provider/provider.dart';

import 'package:mino/providers/moodjournal_provider.dart';
import 'package:mino/pages/splash/splash_screen.dart';

// Import AuthProvider baru Anda (Arsitektur ideal)
import 'package:mino/providers/auth_provider.dart';
// Urutan path folder repo-mu
import 'providers/habit_provider.dart';
import 'providers/journal_provider.dart';
import 'providers/mood_provider.dart';
import 'providers/challenge_provider.dart';
import 'providers/profile_provider.dart';
import 'providers/theme_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc; // 🔥 Tetap gunakan alias agar tidak bentrok dengan keyword Provider bawaan
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';

// 🔥 IMPORT FILE FOCUS TIMER YANG BARU DIBUAT
import 'package:mino/core/data/datasource/focus_timer_remote_datasource.dart';
import 'package:mino/core/data/repositories/focus_timer_repository.dart';

import 'package:mino/core/data/datasource/reflection_remote_datasource.dart';
import 'package:mino/core/data/repositories/reflection_repository.dart';
import 'package:mino/core/presentation/home/bloc/reflection/reflection_bloc.dart';

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
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        // Terapkan AuthProvider Anda di sini menggantikan BLoC lama:
        ChangeNotifierProvider(
          create: (_) => AuthProvider(AuthRemoteDatasource()),
        ),

        // 🔥 DAFTAR DASHBOARD BLOC
        bloc.BlocProvider(
          create: (context) => DashboardBloc(
            DashboardRepository(
              remoteDatasource: DashboardRemoteDatasource(), 
            ),
          ),
        ),

        // 🔥 DAFTAR FOCUS TIMER BLOC (YANG BARU)
        bloc.BlocProvider(
          create: (context) => FocusTimerBloc(
            FocusTimerRepository(
              remoteDatasource: FocusTimerRemoteDatasource(),
            ),
          ),
        ),

        // Reflection
        bloc.BlocProvider(
          create: (context) => ReflectionBloc(
            ReflectionRepositoryImpl(
              remoteDatasource: ReflectionRemoteDatasource(),
            ),
          ),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}