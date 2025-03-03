// lib/screens/projects_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/project_provider.dart';
import '../providers/task_provider.dart';
import '../dialogs/project_form_dialog.dart';
import '../dialogs/delete_confirmation_dialog.dart';


class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    final projects = projectProvider.projects;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Projects',style: TextStyle(color: Colors.white),),
      ),
      body: projects.isEmpty
          ? const Center(child: Text('No projects yet. Add your first one!'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: projects.length,
        itemBuilder: (ctx, i) {
          final project = projects[i];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(int.parse(project.color)),
              ),
              title: Text(
                project.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => ProjectFormDialog(project: project),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => const DeleteConfirmationDialog(
                          title: 'Delete Project',
                          content: 'Are you sure? This will also delete all tasks associated with this project.',
                        ),
                      ).then((confirmed) {
                        if (confirmed == true) {
                          // Delete all tasks related to this project first
                          final taskProvider = Provider.of<TaskProvider>(context, listen: false);
                          final tasks = taskProvider.getTasksByProject(project.id);
                          for (final task in tasks) {
                            taskProvider.deleteTask(task.id);
                          }

                          // Then delete the project
                          projectProvider.deleteProject(project.id);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Project deleted'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => const ProjectFormDialog(),
          );
        },
      ),
    );
  }
}