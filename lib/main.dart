import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:top/config/theme/app_theme.dart';
import 'package:top/config/router/app_router.dart';
import 'package:top/domain/models/habit.dart';
import 'presentation/screens/blocs/blocs.dart';
import 'package:top/domain/models/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  // Register Hive adapters
  Hive.registerAdapter(GoalAdapter());
  Hive.registerAdapter(LogAdapter());
  Hive.registerAdapter(DailyGoalAdapter());
  Hive.registerAdapter(DevelopmentGoalAdapter());
  Hive.registerAdapter(HabitAdapter());

  // Open a box
  final goalsBox = await Hive.openBox<Goal>('goalsBox');
  final dailyGoalsBox = await Hive.openBox<DailyGoal>('dailyGoalsBox');
  final improvGoalsBox = await Hive.openBox<DevelopmentGoal>('improvGoalsBox');
  final keepGoalsBox = await Hive.openBox<DevelopmentGoal>('keepGoalsBox');
  final habitsBox = await Hive.openBox<Habit>('habitsBox');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<GoalBloc>(
          create: (BuildContext context) => GoalBloc(goalsBox)..add(LoadGoals()),
        ),
        BlocProvider<DailyGoalsBloc>(
          create: (BuildContext context) => DailyGoalsBloc(dailyGoalsBox)..add(LoadDailyGoals()),
        ),
        BlocProvider<DevelopmentGoalsBloc>(
          create: (BuildContext context) =>
              DevelopmentGoalsBloc(improvGoalsBox, keepGoalsBox)..add(LoadDevGoals()),
        ),
        BlocProvider<HabitsBloc>(
          create: (BuildContext context) => HabitsBloc(habitsBox)..add(LoadHabits()),
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
