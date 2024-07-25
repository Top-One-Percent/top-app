// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitAdapter extends TypeAdapter<Habit> {
  @override
  final int typeId = 4;

  @override
  Habit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Habit(
      id: fields[0] as String?,
      name: fields[1] as String,
      frequency: (fields[2] as List).cast<int>(),
      remidersTime: (fields[3] as List?)?.cast<String>(),
      steps: (fields[4] as List?)?.cast<String>(),
      linkedGoalId: fields[5] as String?,
      color: Color(fields[6]),
      icon: fields[7] as String,
      unitType: fields[8] as String,
      habitLogs: (fields[9] as List?)?.cast<HabitLog>(),
      target: fields[10] as double,
      dailyHabitLogs: (fields[11] as List?)?.cast<HabitLog>(),
    );
  }

  @override
  void write(BinaryWriter writer, Habit obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.frequency)
      ..writeByte(3)
      ..write(obj.remidersTime)
      ..writeByte(4)
      ..write(obj.steps)
      ..writeByte(5)
      ..write(obj.linkedGoalId)
      ..writeByte(6)
      ..write(obj.colorValue)
      ..writeByte(7)
      ..write(obj.icon)
      ..writeByte(8)
      ..write(obj.unitType)
      ..writeByte(9)
      ..write(obj.habitLogs)
      ..writeByte(10)
      ..write(obj.target)
      ..writeByte(11)
      ..write(obj.dailyHabitLogs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

class HabitLogAdapter extends TypeAdapter<HabitLog> {
  @override
  final int typeId = 5;

  @override
  HabitLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitLog(
      date: fields[0] as DateTime,
      complianceRate: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, HabitLog obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.complianceRate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitLogAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
