import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/project.dart';

class ProjectProvider with ChangeNotifier {
  late Box<Project> _projectsBox;

  ProjectProvider() {
    _initBox();
  }

  Future<void> _initBox() async {
    if (!Hive.isBoxOpen('projects')) {
      _projectsBox = await Hive.openBox<Project>('projects');
    } else {
      _projectsBox = Hive.box<Project>('projects');
    }
    notifyListeners();
  }

  List<Project> get projects {
    if (!Hive.isBoxOpen('projects')) return [];
    return _projectsBox.values.toList();
  }

  Project? getProjectById(String id) {
    if (!Hive.isBoxOpen('projects')) return null;
    try {
      return _projectsBox.values.firstWhere((project) => project.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> addProject(Project project) async {
    if (!Hive.isBoxOpen('projects')) return;
    await _projectsBox.add(project);
    notifyListeners();
  }

  Future<void> updateProject(Project project) async {
    if (!Hive.isBoxOpen('projects')) return;
    final projectInBox = _projectsBox.values.firstWhere((p) => p.id == project.id);
    final index = projectInBox.key;
    await _projectsBox.put(index, project);
    notifyListeners();
  }

  Future<void> deleteProject(String id) async {
    if (!Hive.isBoxOpen('projects')) return;
    final projectToDelete = _projectsBox.values.firstWhere((project) => project.id == id);
    await _projectsBox.delete(projectToDelete.key);
    notifyListeners();
  }
}
