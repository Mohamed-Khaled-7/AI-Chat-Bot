<div align="center">

# 🤖 AI Chat Bot

### A Flutter chat application powered by the Google Gemini API

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.12-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Gemini API](https://img.shields.io/badge/Gemini-API-4285F4?logo=google&logoColor=white)](https://ai.google.dev)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Windows%20%7C%20macOS-lightgrey)]()
[![License](https://img.shields.io/badge/License-MIT-green.svg)](#license)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)]()

</div>

---

## 📖 Overview

**AI Chat Bot** is a cross-platform Flutter application that lets users chat in real time with Google's **Gemini** large language model. It follows a clean, layered architecture (core / feature separation), uses **Cubit** for predictable state management, and keeps API credentials safely out of source control via `.env`.

---

## 📑 Table of Contents

- [Features](#-features)
- [Tech Stack](#️-tech-stack)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Environment Setup](#environment-setup)
  - [Run the App](#run-the-app)
- [How the Gemini Integration Works](#️-how-the-gemini-integration-works)
- [Architecture](#-architecture)
- [Roadmap](#-roadmap)
- [Contributing](#-contributing)
- [Troubleshooting](#-troubleshooting)
- [License](#-license)

---

## ✨ Features

- 💬 Real-time chat interface with a message list, input field, and send action
- ⚡ Direct integration with the **Gemini API** via `Dio`
- 🧠 Predictable state management using **flutter_bloc (Cubit)**
- 🧩 Clean dependency injection using **get_it**
- 🧭 Declarative navigation using **go_router**
- 🔐 Secure API key handling via **flutter_dotenv** (`.env`, never committed)
- ⏳ Dedicated UI states for loading and failure (with retry-friendly bubbles)
- 🎨 Custom design system — colors, spacing, radius, shadows, and typography (Google Fonts)
- 📱 Multi-platform: Android, iOS, Web, Windows, macOS

---

## 🛠️ Tech Stack

| Package          | Purpose                                |
| ---------------- | --------------------------------------- |
| `flutter_bloc`   | State management (Cubit)                |
| `dio`            | HTTP client for Gemini API requests      |
| `go_router`      | Declarative routing / navigation         |
| `get_it`         | Dependency injection / service locator   |
| `flutter_dotenv` | Loading environment variables (API key)  |
| `google_fonts`   | Custom app typography                    |

---

## 📂 Project Structure

```
lib/
├── core/
│   ├── const/          # App-wide constants (API key)
│   ├── services/        # GeminiChatService + ApiClient (Dio wrapper)
│   ├── shared/          # Design tokens: spacing, radius, shadows, text styles
│   ├── theme/            # App color palette
│   ├── utils/            # Router config + GetIt service locator setup
│   └── widgets/           # Shared/reusable widgets (e.g. custom snackbar)
│
├── feature/
│   └── chat/
│       ├── models/                # ChatMessage, Message data models
│       ├── presentation/
│       │   ├── cubit/               # SendMessageCubit + SendMessageState
│       │   └── screens/             # ChatView + all chat UI widgets
│       └── repositories/           # SendMessageRepository (abstraction + impl)
│
└── main.dart              # App entry point (env load, DI setup, MaterialApp)
```

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) ≥ 3.x
- A Gemini API key from [Google AI Studio](https://aistudio.google.com/app/apikey)

### Installation

```bash
git clone <repo-url>
cd AI-Chat-Bot-develop
flutter pub get
```

### Environment Setup

Create a `.env` file in the project root (next to `pubspec.yaml`):

```env
GEMINI_API_KEY=your_gemini_api_key_here
```

> ⚠️ **Security note:** `.env` must be listed in `.gitignore`. Never commit real API keys to version control.

### Run the App

```bash
flutter run
```

To target a specific platform:

```bash
flutter run -d chrome     # Web
flutter run -d windows    # Windows
flutter run -d macos      # macOS
```

---

## ⚙️ How the Gemini Integration Works

All AI communication is encapsulated in `GeminiChatService`, which calls the Gemini `generateContent` endpoint:

```
https://generativelanguage.googleapis.com/v1beta/models/{model}:generateContent
```

- **Current model:** `gemini-3.6-flash`
- **Auth:** the API key is sent via the `x-goog-api-key` request header
- **Flow:** `SendMessageCubit` → `SendMessageRepository` → `GeminiChatService` → `ApiClient` (Dio) → Gemini API
- The raw JSON response is parsed into a `ChatMessageModel` and rendered as a message bubble in the UI

To switch models, update `_model` and `_url` in:
`lib/core/services/gemini_chat_service.dart`

---

## 🏗️ Architecture

The project follows a **feature-first, layered architecture**:

- **`core/`** — cross-cutting concerns shared across the whole app (theming, networking, DI, routing)
- **`feature/chat/`** — everything related to the chat feature, split into `models`, `presentation` (UI + state), and `repositories` (data access)
- State flows one way: **UI → Cubit → Repository → Service → API**, keeping business logic out of widgets

---

## 🗺️ Roadmap

- [ ] Persist chat history locally (Hive / SQLite)
- [ ] Streaming responses (token-by-token rendering)
- [ ] Multi-conversation support
- [ ] Markdown & code-block rendering in messages
- [ ] Voice input support

---

## 🤝 Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request

Please keep PRs focused and follow the existing project structure and naming conventions.

---

## 🩺 Troubleshooting

| Issue | Likely Cause | Fix |
|---|---|---|
| `401 Unauthorized` | Invalid or missing API key | Verify `GEMINI_API_KEY` in `.env` and regenerate it in AI Studio if needed |
| No response / timeout | No internet connection | Check device/emulator network connectivity |
| `.env` not found | File missing or misnamed | Ensure `.env` sits at the project root and is listed under `assets:` in `pubspec.yaml` |

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

<div align="center">
Made with ❤️ using Flutter
</div>
