import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/time_entry.dart';
import '../models/project.dart';
import '../models/task.dart';
import '../providers/project_provider.dart';
import '../providers/task_provider.dart'; // You'll need to create this or modify existing

class NewEntryScreen extends StatefulWidget {
  const NewEntryScreen({super.key});

  @override
  State<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _selectedProjectId = '';
  late String _selectedTaskId = '';
  final _noteController = TextEditingController();
  final _hoursController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Initialize project ID and task ID in the next frame when the context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final projects = Provider.of<ProjectProvider>(context, listen: false).projects;
      if (projects.isNotEmpty) {
        setState(() {
          _selectedProjectId = projects.first.id;
        });

        // Initialize task ID based on the selected project
        final tasks = Provider.of<TaskProvider>(context, listen: false)
            .getTasksByProject(_selectedProjectId);
        if (tasks.isNotEmpty) {
          setState(() {
            _selectedTaskId = tasks.first.id;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _noteController.dispose();
    _hoursController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveEntry() {
    if (_formKey.currentState!.validate()) {
      // Get project name from selected project
      final projectProvider = Provider.of<ProjectProvider>(context, listen: false);
      final selectedProject = projectProvider.getProjectById(_selectedProjectId);

      // Get task name from selected task
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      final selectedTask = taskProvider.getTaskById(_selectedTaskId);

      if (selectedProject == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a project'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      if (selectedTask == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a task'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      // Create a new TimeEntry object
      final newEntry = TimeEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        projectName: selectedProject.name,
        task: selectedTask.title, // Using title from your Task model
        note: _noteController.text,
        hours: double.parse(_hoursController.text),
        date: _selectedDate,
      );

      // Return the new entry to the previous screen
      Navigator.pop(context, newEntry);
    }
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    final taskProvider = Provider.of<TaskProvider>(context);

    final projects = projectProvider.projects;
    final tasks = taskProvider.getTasksByProject(_selectedProjectId);

    // Check if there are no projects
    if (projects.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Time Entry'),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Please create a project first before adding time entries.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      );
    }

    // Check if there are no tasks for the selected project
    if (tasks.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Time Entry'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Please create tasks for this project before adding time entries.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to task creation screen
                    // You'll need to implement this navigation
                    Navigator.pop(context);
                  },
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Time Entry'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedProjectId.isNotEmpty ? _selectedProjectId : projects.first.id,
                decoration: const InputDecoration(
                  labelText: 'Project',
                  border: OutlineInputBorder(),
                ),
                items: projects.map((Project project) {
                  return DropdownMenuItem<String>(
                    value: project.id,
                    child: Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Color(int.parse(project.color)),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(project.name),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedProjectId = newValue!;

                    // Reset task selection when project changes
                    final projectTasks = taskProvider.getTasksByProject(_selectedProjectId);
                    if (projectTasks.isNotEmpty) {
                      _selectedTaskId = projectTasks.first.id;
                    } else {
                      _selectedTaskId = '';
                    }
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a project';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedTaskId.isNotEmpty ? _selectedTaskId : (tasks.isNotEmpty ? tasks.first.id : null),
                decoration: const InputDecoration(
                  labelText: 'Task',
                  border: OutlineInputBorder(),
                ),
                items: tasks.map((Task task) {
                  return DropdownMenuItem<String>(
                    value: task.id,
                    child: Text(task.title), // Using title from your Task model
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedTaskId = newValue;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a task';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(
                  labelText: 'Note',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _hoursController,
                decoration: const InputDecoration(
                  labelText: 'Hours',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter hours';
                  }
                  try {
                    double hours = double.parse(value);
                    if (hours <= 0) {
                      return 'Hours must be greater than 0';
                    }
                  } catch (e) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Text(
                    'Date: ${DateFormat('MMM dd, yyyy').format(_selectedDate)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveEntry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('SAVE ENTRY'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}