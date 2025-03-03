# Time Tracker - Flutter App

![Flutter](https://img.shields.io/badge/Flutter-3.13-blue?style=flat&logo=flutter) ![Dart](https://img.shields.io/badge/Dart-3.0-blue?style=flat&logo=dart) ![License](https://img.shields.io/badge/License-MIT-green.svg)

A **productivity app** that helps users track time spent on different projects and tasks efficiently.

## 🚀 Project Status
🔧 **Currently in Development** - The app is being refactored from its previous version (`time_tracker_new`) to a more structured and optimized architecture.

## 📌 Overview
Time Tracker allows users to:

✅ Create and manage projects
✅ Track time spent on different tasks
✅ View time analytics and reports
✅ Customize themes (Light/Dark mode)

---

## ✨ Features
- **Project Management**: Create, edit, and organize projects
- **Time Tracking**: Log time entries for tasks and projects
- **Theme Support**: Toggle between light and dark modes
- **Persistent Storage**: Uses Hive for offline data storage

---

## 🛠️ Technical Details
### Architecture
- **Flutter**: Cross-platform development
- **Provider Pattern**: Manages state efficiently
- **Hive**: Lightweight NoSQL database for data persistence

### Key Components
#### 📌 Providers
- **`ProjectProvider`**: Manages project data and operations
- **`ThemeProvider`**: Handles theme selection and customization
- **`TaskProvider`**: Manages task data and operations

#### 📌 Screens
- **`ProjectsScreen`**: Displays and manages projects
- **`TasksScreen`**: Shows tasks linked to projects
- **`SettingsScreen`**: App settings and configurations
- **`NewEntryScreen`**: Add new time entry for the project
- **`TimeTrackingScreen`**: Display all the projects/tasks pending

#### 📌 Data Models
- **`Project`**: Represents a project with associated tasks
- **`Task`**: Represents a Task with associated projects
- **`TimeEntry`**: Represents a time-tracking session

---

## 🛠️ Setup & Installation
### Prerequisites
Ensure you have Flutter installed. If not, follow the [Flutter installation guide](https://flutter.dev/docs/get-started/install).

### Clone the Repository
```bash
git clone https://github.com/yourusername/time_tracker.git
cd time_tracker
```

### Install Dependencies
```bash
flutter pub get
```

### Run the Application
```bash
flutter run
```

---

## 🖼️ Screenshots
<img src="https://github.com/user-attachments/assets/29aac944-cc10-450f-9152-41b7c46112f5" width="300" />
<img src="https://github.com/user-attachments/assets/48ad2fd8-a7e9-4d95-97e6-c6d61e225f04" width="300" />
<img src="https://github.com/user-attachments/assets/0cdd99de-71f4-4f37-b12b-f9338491017a" width="300" />
<img src="https://github.com/user-attachments/assets/8613815b-5d0c-4c29-a9e4-fd8f12053677" width="300" />
<img src="https://github.com/user-attachments/assets/1c48d538-b3b0-49c4-a5bd-7a34060dccab" width="300" />
<img src="https://github.com/user-attachments/assets/56f923c3-5209-4bb9-bf0f-b041c53fd0b4" width="300" />
<img src="https://github.com/user-attachments/assets/9e5ccd1b-665a-435d-859f-6f80dffb5667" width="300" />
<img src="https://github.com/user-attachments/assets/d7171757-73e1-41a7-826c-ec33f92d179c" width="300" />
<img src="https://github.com/user-attachments/assets/bca05e8a-e93a-422f-b395-bb1fda388f2c" width="300" />
<img src="https://github.com/user-attachments/assets/788cee9d-f606-48e5-892c-2507bef0a0d3" width="300" />
<img src="https://github.com/user-attachments/assets/6215c158-8c4d-4e94-8126-3ead0d44143f" width="300" />
---

## 🎯 Next Steps
✅ Fix package imports and naming conventions  
✅ Implement missing Hive adapter classes  
✅ Correct file paths in import statements  
✅ Complete screen implementations  
✅ Add comprehensive data persistence  
✅ Implement analytics dashboard  

---

## 🤝 Contributing
Contributions are welcome! Feel free to submit a Pull Request.

---

## 📜 License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

### 📬 Have Questions?
For any queries or suggestions, feel free to **open an issue** or reach out. 🚀
