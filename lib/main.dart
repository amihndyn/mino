import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mino/core/data/datasource/auth_remote_datasource.dart';
import 'package:mino/core/data/datasource/dashboard_remote_datasource.dart';
import 'package:mino/core/data/repositories/dashboard_repository.dart';
import 'package:mino/core/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:mino/core/presentation/home/bloc/focus_timer/focus_timer_bloc.dart';
import 'package:mino/pages/auth/login_page.dart';
import 'package:mino/models/profile_model.dart'; // 💡 Diambil dari main
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mino/providers/moodjournal_provider.dart';
import 'package:mino/pages/splash/splash_screen.dart';

import 'package:mino/providers/auth_provider.dart';
import 'providers/habit_provider.dart';
import 'providers/journal_provider.dart';
import 'providers/mood_provider.dart';
import 'providers/challenge_provider.dart';
import 'providers/profile_provider.dart';
import 'providers/theme_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc; 
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';

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

        // 💡 EKSEKUSI PROFILE_PROVIDER DARI MAIN (Dengan data default Nana)
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

        // 🔥 FITUR KAMU (HEAD): BLOC DASHBOARD
        bloc.BlocProvider(
          create: (context) => DashboardBloc(
            DashboardRepository(
              remoteDatasource: DashboardRemoteDatasource(), 
            ),
          ),
        ),

        // 🔥 FITUR KAMU (HEAD): BLOC FOCUS TIMER
        bloc.BlocProvider(
          create: (context) => FocusTimerBloc(
            FocusTimerRepository(
              remoteDatasource: FocusTimerRemoteDatasource(),
            ),
          ),
        ),

        // 🔥 FITUR KAMU (HEAD): BLOC REFLECTION
        bloc.BlocProvider(
          create: (context) => ReflectionBloc(
            ReflectionRepositoryImpl(
              remoteDatasource: ReflectionRemoteDatasource(),
            ),
          ),
        ),
        
        // ── 🛠️ TAMBAHKAN BLOC LOGOUT DI SINI ──
        bloc.BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // 💡 FITUR THEME DARI MAIN (Menggunakan Font Poppins)
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}