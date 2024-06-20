import 'package:go_router/go_router.dart';
import 'package:top/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/goals',
      builder: (context, state) => const GoalsScreen(),
    ),
    GoRoute(
      path: '/newGoal',
      builder: (context, state) => const AddGoalScreen(),
    ),
    GoRoute(
      path: '/goal/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return SingleGoalScreen(goalId: id);
      },
    ),
    GoRoute(
      path: '/editGoal/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return EditGoalScreen(goalId: id);
      },
    ),
    GoRoute(
      path: '/habits',
      builder: (context, state) => const HabitsScreen(),
    ),
    GoRoute(
      path: '/mindset',
      builder: (context, state) => const MindsetScreen(),
    ),
  ],
);
