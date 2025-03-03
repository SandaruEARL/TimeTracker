// lib/models/task.dart
import 'package:hive/hive.dart';


@HiveType(typeId: 2)
class Task extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  String projectId;

  @HiveField(4)
  DateTime dueDate;

  @HiveField(5)
  int priority;

  @HiveField(6)
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.projectId,
    required this.dueDate,
    required this.priority,
    required this.isCompleted,
  });
}