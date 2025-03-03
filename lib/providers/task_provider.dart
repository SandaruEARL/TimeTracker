import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  late Box<Task> _taskBox;
  bool _isInitialized = false;

  TaskProvider() {
    _init();
  }

  Future<void> _init() async {
    if (!_isInitialized) {
      _taskBox = await Hive.openBox<Task>('tasks');
      _isInitialized = true;
      notifyListeners();
    }
  }

  List<Task> get tasks {
    if (!_isInitialized) return [];
    return _taskBox.values.toList();
  }

  // Get tasks filtered by project ID
  List<Task> getTasksByProject(String projectId) {
    if (!_isInitialized) return [];
    return _taskBox.values
        .where((task) => task.projectId == projectId)
        .toList();
  }

  // Get a specific task by ID
  Task? getTaskById(String id) {
    if (!_isInitialized) return null;
    try {
      return _taskBox.values.firstWhere((task) => task.id == id);
    } catch (e) {
      return null;
    }
  }

  // Add a new task
  Future<void> addTask(Task task) async {
    await _init();
    await _taskBox.put(task.id, task);
    notifyListeners();
  }

  // Update an existing task
  Future<void> updateTask(Task task) async {
    await _init();
    await _taskBox.put(task.id, task);
    notifyListeners();
  }

  // Delete a task
  Future<void> deleteTask(String id) async {
    await _init();
    await _taskBox.delete(id);
    notifyListeners();
  }

  // Create a new task
  Future<Task> createTask({
    required String title,
    required String description,
    required String projectId,
    required DateTime dueDate,
    required int priority,
  }) async {
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      projectId: projectId,
      dueDate: dueDate,
      priority: priority,
      isCompleted: false,
    );

    await addTask(newTask);
    return newTask;
  }

  // Toggle task completion status
  Future<void> toggleTaskCompletion(String id) async {
    final task = getTaskById(id);
    if (task != null) {
      task.isCompleted = !task.isCompleted;
      await updateTask(task);
    }
  }
}