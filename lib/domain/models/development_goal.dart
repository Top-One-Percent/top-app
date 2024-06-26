import 'package:hive/hive.dart';

part 'development_goal.g.dart';

@HiveType(typeId: 3)
class DevelopmentGoal {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final bool isCompleted;

  DevelopmentGoal(this.isCompleted, {required this.name});
}
