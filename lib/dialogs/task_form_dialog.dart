// lib/dialogs/task_form_dialog.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../models/project.dart';
import '../providers/project_provider.dart';
import '../providers/task_provider.dart';

class TaskFormDialog extends StatefulWidget {
  final Task? task;

  const TaskFormDialog({Key? key, this.task}) : super(key: key);

  @override
  State<TaskFormDialog> createState() => _TaskFormDialogState();
}

class _TaskFormDialogState extends State<TaskFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  late String _selectedProjectId;
  late DateTime _selectedDueDate;
  late int _selectedPriority;
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();

    _selectedDueDate = DateTime.now();
    _selectedPriority = 1; // Default: Low
    _isCompleted = false;

    // Set initial values if editing a task
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _selectedProjectId = widget.task!.projectId;
      _selectedDueDate = widget.task!.dueDate;
      _selectedPriority = widget.task!.priority;
      _isCompleted = widget.task!.isCompleted;
    }

    // Initialize project ID in the next frame when the context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final projects = Provider.of<ProjectProvider>(context, listen: false).projects;
      if (projects.isNotEmpty && widget.task == null) {
        setState(() {
          _selectedProjectId = projects.first.id;
        });
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDueDate) {
      setState(() {
        _selectedDueDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    final projects = projectProvider.projects;

    final isEditing = widget.task != null;

    // Check if there are no projects
    if (projects.isEmpty) {
      return AlertDialog(
        title: const Text('Cannot Create Task'),
        content: const Text('Please create a project first before adding tasks.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    }

    // Ensure _selectedProjectId is initialized
    if (!isEditing && _selectedProjectId == null && projects.isNotEmpty) {
      _selectedProjectId = projects.first.id;
    }

    return AlertDialog(
      title: Text(isEditing ? 'Edit Task' : 'Add New Task'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedProjectId,
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
                  if (newValue != null) {
                    setState(() {
                      _selectedProjectId = newValue;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Due Date: ${DateFormat('MMM dd, yyyy').format(_selectedDueDate)}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () => _selectDate(context),
                    icon: const Icon(Icons.calendar_today),
                    label: const Text('Change'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Priority:'),
              Row(
                children: [
                  Expanded(
                    child: Radio<int>(
                      value: 1,
                      groupValue: _selectedPriority,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedPriority = value!;
                        });
                      },
                    ),
                  ),
                  const Text('Low'),
                  Radio<int>(
                    value: 2,
                    groupValue: _selectedPriority,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedPriority = value!;
                      });
                    },
                  ),
                  const Text('Medium'),
                  Radio<int>(
                    value: 3,
                    groupValue: _selectedPriority,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedPriority = value!;
                      });
                    },
                  ),
                  const Text('High'),
                ],
              ),
              if (isEditing) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _isCompleted,
                      onChanged: (bool? value) {
                        setState(() {
                          _isCompleted = value!;
                        });
                      },
                    ),
                    const Text('Mark as completed'),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final taskProvider =
              Provider.of<TaskProvider>(context, listen: false);

              if (isEditing) {
                final updatedTask = Task(
                  id: widget.task!.id,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  projectId: _selectedProjectId,
                  dueDate: _selectedDueDate,
                  priority: _selectedPriority,
                  isCompleted: _isCompleted,
                );
                taskProvider.updateTask(updatedTask);
              } else {
                final newTask = Task(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: _titleController.text,
                  description: _descriptionController.text,
                  projectId: _selectedProjectId,
                  dueDate: _selectedDueDate,
                  priority: _selectedPriority,
                  isCompleted: false,
                );
                taskProvider.addTask(newTask);
              }

              Navigator.of(context).pop();
            }
          },
          child: Text(isEditing ? 'UPDATE' : 'ADD'),
        ),
      ],
    );
  }
}