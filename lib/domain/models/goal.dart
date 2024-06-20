import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'goal.g.dart';

@HiveType(typeId: 0)
class Goal extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int target;

  @HiveField(2)
  final int colorValue;

  @HiveField(3)
  final List<Log> logs;

  @HiveField(4)
  final DateTime targetDate;

  Goal({
    required this.name,
    required this.target,
    required Color color,
    this.logs = const [],
    required this.targetDate,
  }) : colorValue = color.value;

  Color get color => Color(colorValue);
}

@HiveType(typeId: 1)
class Log extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final int currentValue;

  Log({required this.date, required this.currentValue});
}
