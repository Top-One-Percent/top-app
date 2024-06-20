// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyGoalAdapter extends TypeAdapter<DailyGoal> {
  @override
  final int typeId = 2;

  @override
  DailyGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyGoal(
      name: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DailyGoal obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
