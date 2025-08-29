# 📱 DigitalHub

**DigitalHub** is a modern Flutter app that provides users with a feature-rich experience including authentication, home dashboard, article details, and search functionality.  
The app is built using **clean architecture principles** to ensure maintainable, scalable, and testable code.
---

## 🚀 Features

- 🔐 **Auth** module for authentication
- 🏠 **Home** module for main content
- 📖 **Article Details** module for detailed reading
- 🔎 **Search** module for content discovery
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
- **/repo:** Abstracts api service access and provides feature logic

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
- `cached_network_image: ^3.4.1` – Efficient image loading with caching
---
## 📊 Data Flow & App Functionality

This document outlines the full data flow of the **DigitalHub** app.  
The app follows **clean architecture principles**, supports online data fetching via API, and handles local caching or offline scenarios if implemented.

---

### 1. Home Feature – Initial Load
- Upon entering the **home** feature, a **loading indicator** is shown while initializing data.
- The **ViewModel** starts the **data-fetching process** for the home content.
- 📑 Empty State Handling: If no articles are available in a tab (e.g., Technology), the app displays a friendly message with a logo/icon 📰 saying “No articles available” instead of leaving the screen blank.
---


### 2. Article_Details Feature
- When a user selects an article, the **article_details** feature fetches the article content.
- The ViewModel retrieves data from the repository, which may fetch from API or cache.
- The UI displays the article content and related information.

---

### 3. Search Feature
- The **search** feature allows users to find content across the app.
- The ViewModel queries the search repository for results from API or cache.
- Results are displayed in the UI as a list or grid.

---

### 4. Error Handling
- Errors during API requests, repository access, or data parsing trigger **user-friendly error messages**.
- Retry options may be provided for failed operations.

---
### 🔹 Failure Class
- Base class for all failures.
- Holds a simple `errorMessage` describing the issue.

---

### 🔹 ServerFailure Class
- Extends `Failure` and specializes in handling **DioException**.
- Maps Dio’s exception types and HTTP status codes into **user-friendly messages**.

#### 🔸 Exception Type Mapping
| DioExceptionType       | Behavior / Message |
|------------------------|--------------------|
| `connectionTimeout`    | `"connectionTimeout"` |
| `sendTimeout`          | `"sendTimeout"` |
| `receiveTimeout`       | `"receiveTimeout"` |
| `badCertificate`       | `"badCertificate"` |
| `cancel`               | `"request canceled"` |
| `connectionError`      | `"connection error"` |
| `unknown`              | `"there was an error , please try later"` |
| `badResponse`          | Handled separately based on HTTP status code |

---

#### 🔸 HTTP Status Code Handling (badResponse)
When the server responds with an error, the app maps **specific status codes**:

| Status Code | Meaning | App Behavior |
|-------------|---------|--------------|
| **401 Unauthorized** | User is not authorized (invalid token, session expired) | Shows `message` from API response |
| **404 Not Found** | Requested resource does not exist | Shows `message` from API response |
| **426 Upgrade Required** | Client must upgrade (e.g., outdated app version) | Shows `message` from API response, often prompting update |
| **429 Too Many Requests** | Rate limiting (too many API calls) | Shows `message` from API response, asks user to slow down |
| **Other Codes** | Any unhandled server error | Defaults to `"there was an error , please try later"` |

### 5. Displaying Data
- When data fetching succeeds:
    - The **ViewModel updates its state**.
    - The **UI listens to the ViewModel** and displays content from each feature:
        - `home` – Dashboard content
        - `article_details` – Article content and metadata
        - `search` – Search results
