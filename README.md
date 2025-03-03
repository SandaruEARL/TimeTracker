# TimeTracker

A Flutter application for tracking time spent on projects and tasks.
Project Status
Currently in Development - The app is undergoing refactoring from its previous version (time_tracker_new) to the current structure.
Overview
Time Tracker is a productivity application that allows users to:

Create and manage projects
Track time spent on different tasks
View time analytics and reports
Customize the app with different themes

Features

Project Management: Create, edit, and organize projects
Time Tracking: Record time entries for specific tasks and projects
Theme Support: Toggle between light and dark themes
Persistent Storage: Data is stored locally using Hive

Technical Details
Architecture

Built with Flutter for cross-platform compatibility
Uses Provider pattern for state management
Implements Hive for local data persistence

Key Components

Providers:

ProjectProvider: Manages project data and operations
ThemeProvider: Handles theme selection and customization


Screens:

ProjectsScreen: Displays and manages projects
TasksScreen: Shows tasks associated with projects
SettingsScreen: App configuration options


Data Models:

Project: Represents a project with associated tasks
TimeEntry: Represents a time tracking session



Setup and Installation

Clone the repository

bashCopygit clone https://github.com/yourusername/time_tracker.git

Install dependencies

bashCopyflutter pub get

Run the application

bashCopyflutter run
Known Issues

Package resolution errors between "time_tracker" and "time_tracker_new"
File path inconsistencies in import statements
Missing adapter implementations for Hive models

Next Steps

 Fix package imports and naming conventions
 Implement missing adapter classes
 Correct file paths in import statements
 Complete screen implementations
 Add comprehensive data persistence
 Implement analytics dashboard

Contributing
Contributions are welcome! Please feel free to submit a Pull Request.
License
This project is licensed under the MIT License - see the LICENSE file for details.

<img src="https://github.com/user-attachments/assets/29aac944-cc10-450f-9152-41b7c46112f5" width="300" /><br>
<img src="https://github.com/user-attachments/assets/48ad2fd8-a7e9-4d95-97e6-c6d61e225f04" width="300" /><br>
<img src="https://github.com/user-attachments/assets/0cdd99de-71f4-4f37-b12b-f9338491017a" width="300" /><br>
<img src="https://github.com/user-attachments/assets/8613815b-5d0c-4c29-a9e4-fd8f12053677" width="300" /><br>
<img src="https://github.com/user-attachments/assets/1c48d538-b3b0-49c4-a5bd-7a34060dccab" width="300" /><br>
<img src="https://github.com/user-attachments/assets/56f923c3-5209-4bb9-bf0f-b041c53fd0b4" width="300" /><br>
<img src="https://github.com/user-attachments/assets/9e5ccd1b-665a-435d-859f-6f80dffb5667" width="300" /><br>
<img src="https://github.com/user-attachments/assets/d7171757-73e1-41a7-826c-ec33f92d179c" width="300" /><br>
<img src="https://github.com/user-attachments/assets/bca05e8a-e93a-422f-b395-bb1fda388f2c" width="300" /><br>
<img src="https://github.com/user-attachments/assets/788cee9d-f606-48e5-892c-2507bef0a0d3" width="300" /><br>
<img src="https://github.com/user-attachments/assets/6215c158-8c4d-4e94-8126-3ead0d44143f" width="300" />
