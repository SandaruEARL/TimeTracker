// lib/widgets/grouped_by_projects_tab.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/time_entry.dart';

class GroupedByProjectsTab extends StatelessWidget {
  final List<TimeEntry> entries;

  const GroupedByProjectsTab({
    Key? key,
    required this.entries,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Group entries by project
    Map<String, List<TimeEntry>> groupedEntries = {};

    for (var entry in entries) {
      if (groupedEntries.containsKey(entry.projectName)) {
        groupedEntries[entry.projectName]!.add(entry);
      } else {
        groupedEntries[entry.projectName] = [entry];
      }
    }

    List<String> projectNames = groupedEntries.keys.toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: projectNames.length,
      itemBuilder: (context, index) {
        final projectName = projectNames[index];
        final projectEntries = groupedEntries[projectName]!;

        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  projectName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(),
                ...projectEntries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'Task: ${entry.task} - ${entry.hours} hours (${DateFormat('MMM dd, yyyy').format(entry.date)})',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}