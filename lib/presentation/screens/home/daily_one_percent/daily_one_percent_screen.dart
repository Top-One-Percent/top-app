import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top/presentation/screens/blocs/blocs.dart';
import 'package:top/presentation/screens/home/daily_one_percent/daily_goal_list_tile.dart';
import 'package:top/presentation/screens/home/daily_one_percent/dev_goal_list_tile.dart';
import 'package:top/presentation/screens/home/daily_one_percent/new_dop_goal_popup.dart';

class DailyOnePercentScreen extends StatelessWidget {
  const DailyOnePercentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15.0),
              //! --------TO-DO-----------
              BlocBuilder<DailyGoalsBloc, DailyGoalsState>(
                builder: (context, state) {
                  return _TitleClearAndAdd(
                    title: 'TO-DO',
                    isAnyCompleted: _isAnyGoalCompleted(state.dailyGoals),
                  );
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: context.watch<DailyGoalsBloc>().state.dailyGoals.length,
                itemBuilder: (context, index) {
                  final goal = context.watch<DailyGoalsBloc>().state.dailyGoals[index];
                  return Dismissible(
                    key: ValueKey(goal),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      padding: const EdgeInsets.only(right: 15.0),
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: const Icon(
                        Icons.delete_sweep,
                        color: Colors.white,
                        size: 35.0,
                      ),
                    ),
                    child: FadeInDown(
                      from: 20,
                      duration: const Duration(milliseconds: 300),
                      child: DailyGoalListTile(
                        goal: goal,
                        goalId: index,
                      ),
                    ),
                    onDismissed: (direction) {
                      context.read<DailyGoalsBloc>().add(RemoveDailyGoal(dailyGoalId: index));
                    },
                  );
                },
              ),
              const Divider(),
              //! --------TO IMPROVE-----------
              BlocBuilder<DevelopmentGoalsBloc, DevelopmentGoalsState>(
                builder: (context, state) {
                  return _TitleClearAndAdd(
                    title: 'To Improve',
                    isAnyCompleted: _isAnyGoalCompleted(state.toImprove),
                    list: DevelopmentList.toImprove,
                  );
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: context.watch<DevelopmentGoalsBloc>().state.toImprove.length,
                itemBuilder: (context, index) {
                  final goal = context.watch<DevelopmentGoalsBloc>().state.toImprove[index];
                  return Dismissible(
                    key: ValueKey(goal),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      padding: const EdgeInsets.only(right: 15.0),
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: const Icon(
                        Icons.delete_sweep,
                        color: Colors.white,
                        size: 35.0,
                      ),
                    ),
                    child: FadeInDown(
                        from: 20,
                        duration: const Duration(milliseconds: 300),
                        child: DevGoalListTile(
                          goal: goal,
                          goalId: index,
                          list: DevelopmentList.toImprove,
                        )),
                    onDismissed: (direction) {
                      context
                          .read<DevelopmentGoalsBloc>()
                          .add(RemoveDevGoal(devGoalId: index, list: DevelopmentList.toImprove));
                    },
                  );
                },
              ),
              const Divider(),

              //! --------TO KEEP-----------
              BlocBuilder<DevelopmentGoalsBloc, DevelopmentGoalsState>(
                builder: (context, state) {
                  return _TitleClearAndAdd(
                    title: 'To Keep',
                    isAnyCompleted: _isAnyGoalCompleted(state.toImprove),
                    list: DevelopmentList.toKeep,
                  );
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: context.watch<DevelopmentGoalsBloc>().state.toKeep.length,
                itemBuilder: (context, index) {
                  final goal = context.watch<DevelopmentGoalsBloc>().state.toKeep[index];
                  return Dismissible(
                    key: ValueKey(goal),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      padding: const EdgeInsets.only(right: 15.0),
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: const Icon(
                        Icons.delete_sweep,
                        color: Colors.white,
                        size: 35.0,
                      ),
                    ),
                    child: FadeInDown(
                      from: 20,
                      duration: const Duration(milliseconds: 300),
                      child: DevGoalListTile(
                        goal: goal,
                        goalId: index,
                        list: DevelopmentList.toKeep,
                      ),
                    ),
                    onDismissed: (direction) {
                      context
                          .read<DevelopmentGoalsBloc>()
                          .add(RemoveDevGoal(devGoalId: index, list: DevelopmentList.toKeep));
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isAnyGoalCompleted(List<dynamic> goals) {
    if (goals.isEmpty) return false;
    for (var goal in goals) {
      if (goal.isCompleted) {
        return true;
      }
    }
    return false;
  }
}

void clearGoalsList(DevelopmentList? list, BuildContext context) {
  // Assuming `list` is already defined somewhere in your context
  late List<dynamic> goalsList;
  dynamic bloc;
  String eventType;

  if (list == null) {
    goalsList = context.read<DailyGoalsBloc>().state.dailyGoals;
    bloc = context.read<DailyGoalsBloc>();
    eventType = 'Daily';
  } else {
    if (list == DevelopmentList.toImprove) {
      goalsList = context.read<DevelopmentGoalsBloc>().state.toImprove;
    } else if (list == DevelopmentList.toKeep) {
      goalsList = context.read<DevelopmentGoalsBloc>().state.toKeep;
    }
    bloc = context.read<DevelopmentGoalsBloc>();
    eventType = 'Development';
  }

// Reverse iteration to safely modify the list during iteration
  for (int i = goalsList.length - 1; i >= 0; i--) {
    if (goalsList[i].isCompleted) {
      if (eventType == 'Daily') {
        bloc.add(RemoveDailyGoal(dailyGoalId: i));
      } else {
        bloc.add(RemoveDevGoal(list: list!, devGoalId: i));
      }
    }
  }
}

class _TitleClearAndAdd extends StatelessWidget {
  final String title;
  final DevelopmentList? list;
  final bool isAnyCompleted;

  const _TitleClearAndAdd({required this.title, this.list, required this.isAnyCompleted});

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      from: 70,
      duration: const Duration(milliseconds: 200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24.0),
          ),
          Row(
            children: [
              isAnyCompleted
                  ? ElasticIn(
                      child: Spin(
                        spins: 1,
                        child: IconButton(
                          onPressed: () {
                            clearGoalsList(list, context);
                          },
                          icon: const Icon(
                            Icons.replay_outlined,
                            size: 30.0,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(width: 10.0),
              FloatingActionButton.small(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => NewDopGoalPopup(list: list),
                  );
                },
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
