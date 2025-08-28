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
│
└── digital_hub.dart   
```

---

## 🛠️ Getting Started

## 🧠 Clean Architecture Overview

DigitalHub follows a **feature-based clean architecture**, separating the code into clear layers for maintainability and scalability.

---

### 🧩 Feature Layer

Each feature (`home`, `auth`, `article_details`, `search`) includes:

#### 1. Presentation Layer
- **Location:** `/feature/[feature_name]/presentation/`
- **/view:** Displays UI (Flutter widgets)
- **/view_model:** Handles business logic and state (interacts with repository)
- **Note:** Presentation **does not** directly call APIs or databases.

#### 2. Data Layer
- **Location:** `/feature/[feature_name]/data/`
- **/models:** Dart models (e.g., `Article`, `User`)
- **/data_source:** Handles remote (Dio) or local (Hive) data access
- **/repo:** Abstracts data source access and provides feature logic

> 🧠 Repositories act as a middleman between ViewModels and raw data sources.
### Installation

```bash
api Key 8c7b3a78bd654b028ee298ed9d59eaed
api Key2 a3679a4e4deb43b8a0ae60544dc52f50
```

---

## 📦 Dependencies

The project uses the following packages (as listed in `pubspec.yaml`):

- `dio: ^5.9.0` – API service
- `flutter_bloc: ^9.1.1` – State management
- `animated_toggle_switch: ^0.8.5` – Custom animated toggle switches
- `url_launcher: ^6.3.0` – Launch URLs in browser or external apps
- `dartz: ^0.10.1` – function can take two return type
---
## 🤝 Contributing

1. Fork the repo
2. Create a new branch (`feature/my-feature`)
3. Commit changes
4. Push branch
5. Open a Pull Request

---
