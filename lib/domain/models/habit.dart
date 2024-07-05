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
  final List<int> frequency; // Storing days as integers (0=Monday, 1=Tuesday...)

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
    this.habitLogs = const [],
    required this.target,
    this.dailyHabitLogs = const [],
  })  : colorValue = color.value,
        id = id ?? const Uuid().v4();
}

@HiveType(typeId: 5)
class HabitLog extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final double complianceRate;

  HabitLog({required this.date, required this.complianceRate});
}
