// lib/screens/time_tracking_screen.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/time_entry.dart';
import '../widgets/all_entries_tab.dart';
import '../widgets/grouped_project_tab.dart';
import '../widgets/app_drawer.dart';
import 'new_entry_screen.dart';

class TimeTrackingScreen extends StatefulWidget {
  const TimeTrackingScreen({Key? key}) : super(key: key);

  @override
  State<TimeTrackingScreen> createState() => _TimeTrackingScreenState();
}

class _TimeTrackingScreenState extends State<TimeTrackingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Box<TimeEntry> _entriesBox;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _entriesBox = Hive.box<TimeEntry>('time_entries');
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _deleteEntry(String id) {
    final entryToDelete = _entriesBox.values.firstWhere((entry) => entry.id == id);
    entryToDelete.delete();
    setState(() {});
  }

  Future<void> _addNewEntry() async {
    // Navigate to the new entry screen and wait for result
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewEntryScreen()),
    );

    // If a new entry was returned, add it to the box
    if (result != null && result is TimeEntry) {
      await _entriesBox.add(result);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {


    final textColor = Colors.white; // Ensure it's always white or light

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Time Tracking',style: TextStyle(color: textColor),),centerTitle: true,
        bottom: TabBar(
          labelColor: Colors.white,
          controller: _tabController,
          tabs: const [
            Tab(text: 'All Entries'),
            Tab(text: 'Grouped by Projects'),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body:_entriesBox.isEmpty
          ? const Center(child: Text('No Time entries yet. Add your first one!'))


          :ValueListenableBuilder(
          valueListenable: _entriesBox.listenable(),
          builder: (context, Box<TimeEntry> box, _) {
            final entries = box.values.toList();

            return TabBarView(
              controller: _tabController,
              children: [
                // All Entries Tab
                AllEntriesTab(entries: entries, onDelete: _deleteEntry),

                // Grouped by Projects Tab
                GroupedByProjectsTab(entries: entries),
              ],
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        onPressed: _addNewEntry,
        child: const Icon(Icons.add),
      ),
    );
  }
}