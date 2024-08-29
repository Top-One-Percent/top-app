import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'habit.g.dart';

@HiveType(typeId: 4)
class Habit extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<int>
      frequency; // Storing days as integers (0=Monday, 1=Tuesday...)

  @HiveField(3)
  final List<String>? remidersTime;

  @HiveField(4)
  final List<String>? steps;

  @HiveField(5)
  final String? linkedGoalId;

  @HiveField(6)
  final int colorValue;

  @HiveField(7)
  final String icon;

  @HiveField(8)
  final String unitType;

  @HiveField(9)
  final List<HabitLog> habitLogs;

  @HiveField(10)
  final double target;

  @HiveField(11)
  final List<HabitLog> dailyHabitLogs;

  @HiveField(12)
  final List<int> bestStreak;

  @HiveField(13)
  final List<int> totalDays;

  @HiveField(14)
  final List<double> dailyAvg;

  @HiveField(15)
  final List<double> overallRate;

  Habit({
    String? id,
    required this.name,
    required this.frequency,
    this.remidersTime,
    this.steps,
    this.linkedGoalId,
    required Color color,
    required this.icon,
    required this.unitType,
    List<HabitLog>? habitLogs,
    required this.target,
    List<HabitLog>? dailyHabitLogs,
    List<int>? bestStreak,
    List<int>? totalDays,
    List<double>? dailyAvg,
    List<double>? overallRate,
  })  : colorValue = color.value,
        id = id ?? const Uuid().v4(),
        habitLogs = habitLogs ?? [],
        dailyHabitLogs = dailyHabitLogs ?? [],
        bestStreak = bestStreak ?? [1],
        totalDays = totalDays ?? [0],
        dailyAvg = dailyAvg ?? [0],
        overallRate = overallRate ?? [0];
}

@HiveType(typeId: 5)
class HabitLog extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final double complianceRate;

  HabitLog({required this.date, required this.complianceRate});
}
