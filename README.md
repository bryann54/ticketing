Ticketing App
A modern, cross-platform ticketing application built with Flutter. This project leverages best practices in state management and navigation to provide a seamless and professional user experience, from splash screen to authentication.

✨ Features
Splash Screen with Auth Check: A beautifully animated splash screen that intelligently checks the user's authentication status and navigates to the appropriate screen without a noticeable delay.

State Management with BLoC: Utilizes the BLoC pattern to manage application state, ensuring a predictable and testable flow for user authentication.

Declarative Navigation: Implements AutoRoute for a clean and type-safe approach to navigation, simplifying the routing logic.

Dependency Injection: Uses GetIt for managing dependencies, promoting a decoupled and maintainable codebase.

Environment Management: Integrates flutter_dotenv to handle environment-specific configurations (e.g., API keys, development flags) securely.

Internationalization: Supports multiple languages using Flutter's built-in localization and a custom LocaleProvider.

Responsive UI: Designed to work seamlessly on both light and dark themes and adapt to different screen sizes.

💻 Tech Stack
Framework: Flutter

State Management: flutter_bloc, bloc, provider

Navigation: auto_route

Dependency Injection: get_it, injectable

Configuration: flutter_dotenv

Typography: google_fonts

Utilities: equatable

🚀 Getting Started
Prerequisites
Flutter SDK installed on your machine.

An IDE with Flutter and Dart plugins (e.g., VS Code or Android Studio).

A physical device or emulator to run the app.

Installation
Clone the repository to your local machine:

git clone https://github.com/bryann54/ticketing.git
cd ticketing_app

Install the required dependencies:

flutter pub get

Generate the necessary routing code with auto_route:

flutter pub run build_runner build --delete-conflicting-outputs

Configuration
This project uses flutter_dotenv to manage environment variables.

Create a .env file in the env directory.

Add your necessary environment variables. For a basic setup, you might have something like this:

# .env
API_URL

For development, use env/.dev.env and for release, use env/.env.

Running the App
Connect a device or start an emulator.

Run the app from your terminal or IDE:

flutter run

