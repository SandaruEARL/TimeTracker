// lib/main.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_new/providers/project_provider.dart';
import 'package:time_tracker_new/providers/theme_provider.dart';
import 'adapters/project_adapter.dart';
import 'adapters/task_adapter.dart';
import 'models/time_entry.dart';
import 'models/project.dart';
import 'models/task.dart';
import 'providers/task_provider.dart';
import 'screens/time_tracking_screen.dart';
import 'screens/projects_screen.dart';
import 'screens/tasks_screen.dart';
import 'adapters/time_entry_adapter.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Open your Hive boxes
  Hive.registerAdapter(ProjectAdapter());  // Register adapter for Project model
  Hive.registerAdapter(TaskAdapter());     // Register adapter for Task model
  await Hive.openBox<Project>('projects'); // Open Project box
  await Hive.openBox<Task>('tasks');       // Open Task box;

  // Register adapters
  Hive.registerAdapter(TimeEntryAdapter());
  // Add adapters for Project and Task if needed

  // Open boxes
  await Hive.openBox<TimeEntry>('time_entries');
  // Open other boxes if needed

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProjectProvider()),
        ChangeNotifierProvider(create: (ctx) => TaskProvider()),
        ChangeNotifierProvider(create: (ctx) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Time Flow',
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const TimeTrackingScreen(),
            routes: {
              '/projects': (ctx) => const ProjectsScreen(),
              '/tasks': (ctx) => const TasksScreen(),
            },
          );
        },
      ),
    );
  }
}