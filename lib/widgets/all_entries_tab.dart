
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/time_entry.dart';

class AllEntriesTab extends StatelessWidget {
  final List<TimeEntry> entries;
  final Function(String) onDelete;

  const AllEntriesTab({
    super.key,
    required this.entries,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text(
              entry.projectName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text('Task: ${entry.task}'),
                const SizedBox(height: 4),
                Text('Note: ${entry.note}'),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${entry.hours} hours',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      DateFormat('MMM dd, yyyy').format(entry.date),
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => onDelete(entry.id),
            ),
          ),
        );
      },
    );
  }
}