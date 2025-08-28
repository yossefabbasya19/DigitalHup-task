# 📱 DigitalHub

**DigitalHub** is a Flutter project structured using **clean architecture principles** with clear separation of concerns between `core` utilities and modular `feature` implementations.

---

## 🚀 Features

- 🔐 **Auth** module for authentication
- 🏠 **Home** module for main content
- 📖 **Article Details** module for detailed reading
- 🔎 **Search** module for content discovery
- 🌐 API service layer for backend integration
- 🎨 Theming, color management, and reusable UI components
- ✅ Form validation and error handling

---

## 📂 Project Structure

```
lib/
│
├── core/                        # Shared core modules
│   ├── api_service/             # API handling & network layer
│   ├── constants/               # App-wide constants
│   ├── app_color.dart           # Centralized color definitions
│   ├── theme.dart               # App themes (light/dark)
│   ├── route_manager.dart       # Route & navigation manager
│   ├── validator.dart           # Form validators
│   ├── extensions/              # Dart/Flutter extensions
│   ├── failure.dart             # Failure handling classes
│   └── assets_manager.dart      # Assets path manager
│
├── feature/                     # Feature-based architecture
│   ├── article_details/         # Article details module
│   │   ├── data/                # Data layer (models, repository)
│   │   └── presentation/        # UI layer (views, view models)
│   │
│   ├── auth/                    # Authentication module
│   │   ├── data/                # Data layer (models, repository)
│   │   └── presentation/        # UI layer (views, view models)
│   │
│   ├── home/                    # Home module
│   │   ├── data/                # Data layer (models, repository)
│   │   └── presentation/        # UI layer (views, view models)
│   │
│   └── search/                  # Search module
│       ├── data/                # Data layer (models, repository)
│       └── presentation/        # UI layer (views, view models)
│
└── main.dart                    # Application entry point
```

---

## 🛠️ Getting Started

### Prerequisites
- Install [Flutter](https://docs.flutter.dev/get-started/install)
- Install [Dart](https://dart.dev/get-dart)
- Android/iOS emulator or physical device

### Installation

```bash
# Clone the repository
git clone https://github.com/yossefabbasya19/DigitalHup-task.git

# Go to project directory
cd DigitalHup-task

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## 📦 Dependencies

*(Update with actual ones from `pubspec.yaml`)*

- `dio` – API service
- `flutter_bloc` / `provider` – State management
- `equatable` – Model comparison
- `get_it` – Dependency injection

---

## 🤝 Contributing

1. Fork the repo
2. Create a new branch (`feature/my-feature`)
3. Commit changes
4. Push branch
5. Open a Pull Request

---

## 📜 License

This project is licensed under the **MIT License**.
