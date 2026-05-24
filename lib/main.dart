import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:mino/core/data/datasource/auth_remote_datasource.dart';
import 'package:mino/core/presentation/auth/bloc/login/login_bloc.dart';
import 'package:mino/core/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:mino/core/presentation/auth/bloc/register/register_bloc.dart';
import 'package:mino/pages/splash/splash_screen.dart';

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
    final authRemoteDatasource = AuthRemoteDatasource();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HabitProvider()),
        ChangeNotifierProvider(create: (_) => JournalProvider()),
        ChangeNotifierProvider(create: (_) => MoodProvider()),
        ChangeNotifierProvider(create: (_) => ChallengeProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (_) => LoginBloc(authRemoteDatasource),
          ),
          BlocProvider<RegisterBloc>(
            create: (_) => RegisterBloc(authRemoteDatasource),
          ),
          BlocProvider<LogoutBloc>(
            create: (_) => LogoutBloc(authRemoteDatasource),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
