Sereni Space 🌿

A Flutter-based wellness and mindfulness application designed to help users build healthy habits through journaling, meditation, breathing exercises, and AI-powered self-reflection.

Features
🌸 Mood-based wellness recommendations
📖 Journal reflections with local persistence using Hive
🤖 Gemini AI-powered emotional insights
🧘 Guided meditation sessions
⏱ Meditation countdown timer
🌬 Breathing exercises
🌙 Sleep wellness guidance
🎨 Dynamic theme switching with persistence
📱 Responsive Material 3 UI
Tech Stack
Flutter
Dart
Provider
Hive
Gemini API
Material 3
Architecture
UI Layer
    ↓
Provider Layer
    ↓
Repository / Service Layer
    ↓
Hive Database / Gemini API
Project Structure
lib/
├── core/
│   ├── providers/
│   ├── services/
│   └── theme/
│
├── features/
│   ├── home/
│   ├── journal/
│   ├── meditation/
│   ├── breathe/
│   ├── sleep/
│   └── settings/
│
└── main.dart
Key Learnings
State management using Provider
Local persistence with Hive
API integration using Gemini
Clean architecture principles
Flutter navigation and reusable widgets
Environment variable management using dotenv
