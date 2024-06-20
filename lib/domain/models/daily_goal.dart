import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'daily_goal.g.dart';

@HiveType(typeId: 2)
class DailyGoal extends HiveObject {
  @HiveField(0)
  final String name;

  DailyGoal({required this.name});
}
