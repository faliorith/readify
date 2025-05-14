# Readify

A modern book reading application built with Flutter.

## Features

- Authentication with Firebase (email + password)
- Book search and discovery
- Reading progress tracking
- Favorites management
- Multi-language support (English, Russian, Kazakh)
- Dark/Light theme
- Push notifications
- Profile management

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Firebase project
- Android Studio / VS Code
- Android SDK / Xcode (for iOS development)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/faliorith/readify.git
cd readify
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Firebase:
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add Android and iOS apps to your Firebase project
   - Download and add the configuration files:
     - Android: `google-services.json` to `android/app/`
     - iOS: `GoogleService-Info.plist` to `ios/Runner/`
   - Update `lib/firebase_options.dart` with your Firebase configuration

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
  ├── blocs/          # BLoC state management
  ├── models/         # Data models
  ├── screens/        # UI screens
  ├── services/       # Business logic and API services
  ├── utils/          # Utilities and helpers
  ├── components/     # Reusable widgets
  ├── l10n/          # Localization files
  └── main.dart       # App entry point
```

## Architecture

The app follows the BLoC (Business Logic Component) pattern for state management and clean architecture principles:

- **Presentation Layer**: Screens and widgets
- **Business Logic Layer**: BLoCs and Cubits
- **Data Layer**: Services and Models

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request
