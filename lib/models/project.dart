// lib/models/project.dart
import 'package:hive/hive.dart';


@HiveType(typeId: 1)
class Project extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String color;

  Project({
    required this.id,
    required this.name,
    required this.color,
  });
}