import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top/domain/models/habit.dart';
import 'package:top/presentation/screens/blocs/habits_bloc/habits_bloc.dart';

class HabitHistoricChart extends StatefulWidget {
  final Duration viewDuration;
  final int habitId;

  const HabitHistoricChart({super.key, required this.viewDuration, required this.habitId});

  @override
  _HabitHistoricChartState createState() => _HabitHistoricChartState();
}

class _HabitHistoricChartState extends State<HabitHistoricChart> {
  OverlayEntry? _overlayEntry;
  Offset _bubblePosition = Offset.zero;

  void _showBubble(BuildContext context, Offset position, String info) {
    _bubblePosition = position;
    _overlayEntry = _createOverlayEntry(context, info);
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _hideBubble() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry(BuildContext context, String info) {
    final size = MediaQuery.of(context).size;
    double bubbleWidth = 100;
    double bubbleHeight = 60;

    double left = _bubblePosition.dx - bubbleWidth / 2;
    double top = _bubblePosition.dy - bubbleHeight - 10;

    if (left < 0) left = 10;
    if (left + bubbleWidth > size.width) left = size.width - bubbleWidth - 10;
    if (top < 0) top = _bubblePosition.dy + 10;

    return OverlayEntry(
      builder: (context) => Positioned(
        left: left,
        top: top,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: bubbleWidth,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              info,
              style:
                  const TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int daysCount = _getDaysCount(widget.viewDuration);
    return BlocBuilder<HabitsBloc, HabitsState>(
      builder: (context, state) {
        final Habit habit = state.habits[widget.habitId];

        // Calculate streak using daily habit logs and frequency
        int streak = calculateStreak(habit.dailyHabitLogs, habit.frequency, habit.target);

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: daysCount == 7 ? 7 : 12,
            childAspectRatio: 1,
          ),
          itemCount: daysCount,
          itemBuilder: (context, index) {
            // Align targetDate with the start of the week (Monday)
            DateTime today = DateTime.now();
            int weekday = today.weekday;
            DateTime startOfWeek = today.subtract(Duration(days: weekday - 1));
            DateTime targetDate = startOfWeek.add(Duration(days: index));

            HabitLog? log;
            try {
              log = habit.dailyHabitLogs.firstWhere(
                (log) => isSameDay(log.date, targetDate),
              );
            } catch (e) {
              log = null;
            }

            bool isComplete = log != null && (log.complianceRate / habit.target) >= 1.0;
            bool isStreakDay = isComplete && streak >= 1;

            return GestureDetector(
              onLongPressStart: (details) {
                _showBubble(context, details.globalPosition,
                    'Done: ${log?.complianceRate.round() ?? 0}\nTarget: ${habit.target.round()}');
              },
              onLongPressEnd: (details) {
                _hideBubble();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: log != null
                      ? Color(habit.colorValue)
                          .withOpacity((log.complianceRate / habit.target).clamp(0.0, 1.0))
                      : Colors.transparent,
                  border: Border.all(
                    color: log == null ? Colors.grey[850]! : Colors.white,
                    width: log == null ? 1 : 2,
                  ),
                ),
                child: isComplete
                    ? isStreakDay
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.local_fire_department_outlined),
                              if (daysCount == 7)
                                Text(
                                  '$streak',
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                            ],
                          )
                        : const Icon(Icons.check)
                    : Container(),
              ),
            );
          },
        );
      },
    );
  }

  int _getDaysCount(Duration duration) {
    if (duration == const Duration(days: 7)) {
      return 7;
    } else if (duration == const Duration(days: 30)) {
      return 31;
    } else {
      return 365;
    }
  }

  int calculateStreak(List<HabitLog> dailyHabitLogs, List<int> frequency, double target) {
    int streak = 0;
    for (int i = dailyHabitLogs.length - 1; i >= 0; i--) {
      HabitLog log = dailyHabitLogs[i];
      int dayOfWeek = log.date.weekday % 7; // Convert to 0 (Monday) - 6 (Sunday)

      if (!frequency.contains(dayOfWeek)) {
        // If the habit is not supposed to be done on this day, skip it
        continue;
      }

      if ((log.complianceRate / target) >= 1.0) {
        streak++;
      } else {
        streak = 0; // Reset streak if there's a break
      }
    }
    return streak;
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }
}
