import 'package:go_router/go_router.dart';
import 'package:top/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
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
      path: '/newHabit',
      builder: (context, state) => const NewHabitScreen(),
    ),
    GoRoute(
        path: '/habit/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return SingleHabitScreen(habitId: id);
        }),
    GoRoute(
        path: '/editHabit/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return EditHabitScreen(habitId: id);
        }),
    GoRoute(
      path: '/mentor',
      builder: (context, state) => const MentorScreen(),
    ),
    GoRoute(
      path: '/mentorChat/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return MentorChatScreen(tipId: id);
      },
    ),
  ],
);
