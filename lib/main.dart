import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mino/core/data/datasource/auth_remote_datasource.dart';
import 'package:mino/core/data/datasource/dashboard_remote_datasource.dart';
import 'package:mino/core/data/datasource/user_challenge_local_datasource.dart';
import 'package:mino/core/data/datasource/user_challenge_remote_datasource.dart';
import 'package:mino/core/data/repositories/dashboard_repository.dart';
import 'package:mino/core/data/repositories/user_challenge_repository.dart';
import 'package:mino/core/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:mino/core/presentation/home/bloc/user_challenge/user_challenge_bloc.dart';
import 'package:mino/core/presentation/home/bloc/focus_timer/focus_timer_bloc.dart';
import 'package:mino/pages/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mino/providers/moodjournal_provider.dart';
import 'package:mino/pages/splash/splash_screen.dart';

import 'package:mino/providers/auth_provider.dart';
import 'providers/habit_provider.dart';
import 'providers/journal_provider.dart';
import 'providers/mood_provider.dart';
import 'providers/challenge_provider.dart';
import 'package:mino/providers/profile_provider.dart';
import 'providers/theme_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';

import 'package:mino/core/data/datasource/focus_timer_remote_datasource.dart';
import 'package:mino/core/data/repositories/focus_timer_repository.dart';
import 'package:mino/core/data/datasource/profile_remote_datasource.dart';
import 'package:mino/core/data/repositories/profile_repository.dart';

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

        // Profile Provider
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(ProfileRepository(ProfileRemoteDatasource())),
        ),

        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        ChangeNotifierProvider(
          create: (_) => AuthProvider(AuthRemoteDatasource()),
        ),

        // BLOC DASHBOARD
        bloc.BlocProvider(
          create: (context) => DashboardBloc(
            DashboardRepository(
              remoteDatasource: DashboardRemoteDatasource(), 
            ),
          ),
        ),

        // BLOC FOCUS TIMER
        bloc.BlocProvider(
          create: (context) => FocusTimerBloc(
            FocusTimerRepository(
              remoteDatasource: FocusTimerRemoteDatasource(),
            ),
          ),
        ),

        // BLOC REFLECTION
        bloc.BlocProvider(
          create: (context) => ReflectionBloc(
            ReflectionRepositoryImpl(
              remoteDatasource: ReflectionRemoteDatasource(),
            ),
          ),
        ),
        
        // BLOC LOGOUT
        bloc.BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),

        // BLOC USER CHALLENGE (FIXED COMMENT POSITION)
        bloc.BlocProvider(
          create: (context) => UserChallengeBloc(
            UserChallengeRepository(
              remoteDatasource: UserChallengeRemoteDatasource(),
              localDatasource: UserChallengeLocalDatasource(),
            ),
          )..add(const UserChallengeEvent.fetchUserChallenges()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        home: const SplashPage(),
      ),
    );
  }
}