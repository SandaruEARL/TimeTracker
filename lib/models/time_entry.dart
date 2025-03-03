// lib/models/time_entry.dart
import 'package:hive/hive.dart';


@HiveType(typeId: 0)
class TimeEntry extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String projectName;

  @HiveField(2)
  String task;

  @HiveField(3)
  String note;

  @HiveField(4)
  double hours;

  @HiveField(5)
  DateTime date;

  TimeEntry({
    required this.id,
    required this.projectName,
    required this.task,
    required this.note,
    required this.hours,
    required this.date,
  });
}