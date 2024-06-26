import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

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

  @HiveField(5)
  final String id;

  Goal({
    required this.name,
    required this.target,
    required Color color,
    this.logs = const [],
    required this.targetDate,
    String? id,
  })  : colorValue = color.value,
        id = id ?? const Uuid().v4();

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
