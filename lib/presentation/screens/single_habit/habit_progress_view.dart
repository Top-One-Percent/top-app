import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top/config/theme/app_colors.dart';
import 'package:top/domain/models/habit.dart';
import 'package:top/presentation/screens/blocs/blocs.dart';
import 'package:top/presentation/widgets/widgets.dart';

import 'background_timer.dart';

class HabitProgressView extends StatelessWidget {
  final int habitId;

  const HabitProgressView({super.key, required this.habitId});

  @override
  Widget build(BuildContext context) {
    final habit = context.read<HabitsBloc>().state.habits[habitId];

    return habit.unitType == 'rep'
        ? RepsHabitProgressView(habitId: habitId)
        : TimeHabitProgressView(habitId: habitId);
  }
}

class RepsHabitProgressView extends StatelessWidget {
  final int habitId;

  const RepsHabitProgressView({super.key, required this.habitId});

  bool hasDecimalPart(double number) {
    return number % 1 != 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitsBloc, HabitsState>(
      builder: (context, state) {
        final habit = state.habits[habitId];
        final lastLog = habit.habitLogs.isNotEmpty
            ? habit.habitLogs.last.complianceRate
            : 0.0;
        final achievementPercentage = lastLog / habit.target;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: TweenAnimationBuilder(
                      tween: Tween(begin: 0.0, end: achievementPercentage),
                      duration: const Duration(milliseconds: 400),
                      builder: (context, value, child) =>
                          CircularProgressIndicator(
                        value: value,
                        strokeWidth: 5,
                        backgroundColor: AppColors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color(habit.colorValue)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showUpdateValueDialog(context, habitId, lastLog, habit);
                    },
                    child: Text(
                      hasDecimalPart(lastLog)
                          ? '$lastLog'
                          : '${lastLog.toInt()}',
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularButton(
                    icon: Icons.remove,
                    onPressed: () {
                      if (lastLog - 1 >= 0) {
                        context.read<HabitsBloc>().add(UpdateHabit(
                            habitId: habitId, newComplianceRate: lastLog - 1));
                      }
                    },
                  ),
                  const SizedBox(width: 50.0),
                  CircularButton(
                    icon: Icons.add,
                    onPressed: () {
                      if (lastLog + 1 <= habit.target) {
                        context.read<HabitsBloc>().add(UpdateHabit(
                            habitId: habitId, newComplianceRate: lastLog + 1));
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUpdateValueDialog(
      BuildContext context, int habitId, double currentValue, Habit habit) {
    final TextEditingController valueController =
        TextEditingController(text: '$currentValue');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Update value',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey[850],
          content: TextFormFieldWidget(
            controller: valueController,
            keyboardType: TextInputType.number,
            labelText: '',
            hintText: '',
            icon: Icons.edit,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            WhiteFilledButtonWidget(
              onPressed: () {
                final newValue = double.tryParse(valueController.text);
                if (newValue != null) {
                  context.read<HabitsBloc>().add(UpdateHabit(
                      habitId: habitId,
                      newComplianceRate: newValue.toDouble()));
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(milliseconds: 700),
                      content: Text('Enter a valid number'),
                    ),
                  );
                }
              },
              buttonText: 'Ok',
            )
          ],
        );
      },
    );
  }
}

class TimeHabitProgressView extends StatefulWidget {
  final int habitId;

  const TimeHabitProgressView({super.key, required this.habitId});

  @override
  _TimeHabitProgressViewState createState() => _TimeHabitProgressViewState();
}

class _TimeHabitProgressViewState extends State<TimeHabitProgressView> {
  int _elapsedSeconds = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  Future<void> _initializeTimer() async {
    final initialHabit =
        context.read<HabitsBloc>().state.habits[widget.habitId];
    int initialElapsedSeconds = 0;
    if (initialHabit.habitLogs.isNotEmpty) {
      initialElapsedSeconds =
          initialHabit.habitLogs.last.complianceRate.toInt();
    }

    final int elapsedSeconds = await BackgroundTimer.getElapsedSeconds();
    final bool isRunning = await BackgroundTimer.isRunning();

    setState(() {
      _elapsedSeconds = elapsedSeconds > initialElapsedSeconds
          ? elapsedSeconds
          : initialElapsedSeconds;
      _isRunning = isRunning;
    });

    if (_isRunning) {
      _startTimer();
    }
  }

  void _startTimer() async {
    await BackgroundTimer.startTimer(_elapsedSeconds);
    setState(() {
      _isRunning = true;
    });

    while (_isRunning) {
      await Future.delayed(const Duration(seconds: 1));
      final int elapsedSeconds = await BackgroundTimer.getElapsedSeconds();
      setState(() {
        _elapsedSeconds = elapsedSeconds;
      });
      context.read<HabitsBloc>().add(UpdateHabit(
          habitId: widget.habitId,
          newComplianceRate: _elapsedSeconds.toDouble()));
    }
  }

  void _stopTimer() async {
    await BackgroundTimer.stopTimer();
    setState(() {
      _isRunning = false;
    });
  }

  void _toggleTimer() {
    if (_isRunning) {
      _stopTimer();
    } else {
      _startTimer();
    }
  }

  void _resetTimer() async {
    await BackgroundTimer.stopTimer();
    setState(() {
      _elapsedSeconds = 0;
      _isRunning = false;
    });
    context.read<HabitsBloc>().add(UpdateHabit(
          habitId: widget.habitId,
          newComplianceRate: 0.0,
        ));
  }

  String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitsBloc, HabitsState>(
      builder: (context, state) {
        final habit = state.habits[widget.habitId];
        final achievementPercentage = _elapsedSeconds / habit.target;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: CircularProgressIndicator(
                      value: achievementPercentage,
                      strokeWidth: 5,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color(habit.colorValue)),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '${_formatTime(_elapsedSeconds)}/',
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      Text(
                        _formatTime((habit.target).toInt()),
                        style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(202, 255, 255, 255)),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 100.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularButton(
                    icon: _isRunning ? Icons.pause : Icons.play_arrow,
                    onPressed: _toggleTimer,
                  ),
                  const SizedBox(width: 50.0),
                  CircularButton(
                    icon: Icons.refresh,
                    onPressed: _resetTimer,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class CircularButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CircularButton(
      {super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
      ),
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}
