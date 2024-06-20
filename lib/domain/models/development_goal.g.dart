// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'development_goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DevelopmentGoalAdapter extends TypeAdapter<DevelopmentGoal> {
  @override
  final int typeId = 3;

  @override
  DevelopmentGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DevelopmentGoal(
      name: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DevelopmentGoal obj) {
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
      other is DevelopmentGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
