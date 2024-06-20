import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:top/config/theme/app_theme.dart';
import 'package:top/config/router/app_router.dart';
import 'package:top/domain/models/goal.dart';
import 'presentation/screens/blocs/blocs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  // Register Hive adapters
  Hive.registerAdapter(GoalAdapter());
  Hive.registerAdapter(LogAdapter());

  // Open a box
  final goalsBox = await Hive.openBox<Goal>('goalsBox');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<GoalBloc>(
          create: (BuildContext context) => GoalBloc(goalsBox)..add(LoadGoals()),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}
