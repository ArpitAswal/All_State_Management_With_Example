# Flutter State Management and Local Storage Demo

This project demonstrates three different state management techniques in Flutter: GetX, Provider, and BLoC. It also showcases how to integrate these techniques with local storage solutions.  The app implements a simple ToDo list application, allowing users to add, toggle, and delete tasks.  This example covers both basic state updates and more complex data persistence using databases.

## Project Structure

The project is structured to clearly separate the implementation of each state management approach.  It contains three main screens:

*   **Provider Screen:** Implements the ToDo list using Provider for state management and Hive for local database storage.
*   **Bloc Screen:** Implements the ToDo list using BLoC for state management and SQLite for local database storage.
*   **GetX Screen:** Implements the ToDo list using GetX for state management and SharedPreferences for local storage.

## State Management Techniques

This project explores the following state management approaches:

*   **GetX:** A powerful and lightweight framework that simplifies state management, dependency injection, and routing. It emphasizes ease of use and reduces boilerplate code.  This example demonstrates how to use GetX's reactive programming features (`Obx`) and its controller management.

*   **Provider:** A package that makes it easy to manage and access state anywhere in your app. Built on top of `InheritedWidget`, it provides a flexible solution for both simple and complex state management scenarios. This example shows how to use `ChangeNotifier` and `Consumer` to manage and update the UI.

*   **BLoC (Business Logic Component):** A pattern that separates the business logic of your app from the UI. It uses streams to handle events and state changes, promoting testability and maintainability, especially in larger applications. This example demonstrates how to define events, states, and the BLoC itself, and how to interact with it from the UI.

## Local Storage Integration

The project also demonstrates the integration of local storage solutions with each state management technique:

*   **SharedPreferences (with GetX):**  Used for storing simple key-value pairs.  Suitable for small amounts of data.

*   **Hive (with Provider):** A fast and lightweight NoSQL database.  Ideal for storing more structured data efficiently.

*   **SQLite (with BLoC):** A relational database for more complex data structures and relationships.

## Features

The ToDo list application includes the following features:

*   **Add Task:**  Adds a new task to the list.
*   **Toggle Task:** Marks a task as complete or incomplete.
*   **Delete Task:** Removes a task from the list.
*   **Persistent Data:**  Tasks are saved locally and persist across app restarts.

## Getting Started

1.  **Clone the repository:** `git clone <repository_url>`
2.  **Install dependencies:** `flutter pub get`
3.  **Run the app:** `flutter run`

## Dependencies

The project uses the following dependencies:

*   `get`
*   `provider`
*   `flutter_bloc`
*   `shared_preferences`
*   `hive`
*   `hive_flutter`
*   `sqflite`
