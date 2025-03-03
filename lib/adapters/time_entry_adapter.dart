import 'package:hive/hive.dart';

import '../models/time_entry.dart';






class TimeEntryAdapter extends TypeAdapter<TimeEntry> {
  @override
  final int typeId = 0;

  @override
  TimeEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeEntry(
      id: fields[0] as String,
      projectName: fields[1] as String,
      task: fields[2] as String,
      note: fields[3] as String,
      hours: fields[4] as double,
      date: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TimeEntry obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.projectName)
      ..writeByte(2)
      ..write(obj.task)
      ..writeByte(3)
      ..write(obj.note)
      ..writeByte(4)
      ..write(obj.hours)
      ..writeByte(5)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TimeEntryAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}