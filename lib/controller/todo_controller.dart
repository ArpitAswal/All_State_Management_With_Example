import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/todo_model.dart';

// TodoController manages the state and logic for todo items using GetX
class TodoController extends GetxController {
  // Observable list of todo items
  final todos = <TodoModel>[].obs;

  // Key used for storing todos in SharedPreferences
  static const String _todosKey = 'todos';

  // Initialize the controller
  @override
  void onInit() {
    super.onInit();
    // Load todos from SharedPreferences when the controller is initialized
    loadTodos();
  }

  // Add a new todo item to the list
  // @param title: The title of the new todo item
  void addTodo(String title) {
    todos.add(TodoModel(title: title));
    // Save the updated list to SharedPreferences
    saveTodos();
  }

  // Toggle the completion status of a todo item
  // @param index: The index of the todo item in the list
  void toggleTodo(int index) {
    todos[index].isDone = !todos[index].isDone;
    todos.refresh(); // Refresh for Obx to update
    // Save the updated list to SharedPreferences
    saveTodos();
  }

  // Remove a todo item from the list
  // @param index: The index of the todo item to be removed
  void removeTodo(int index) {
    todos.removeAt(index);
    // Save the updated list to SharedPreferences
    saveTodos();
  }

  // Save the current list of todos to SharedPreferences
  Future<void> saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedTodos =
        json.encode(todos.map((todo) => todo.toJson()).toList());
    await prefs.setString(_todosKey, encodedTodos);
  }

  // Load todos from SharedPreferences
  Future<void> loadTodos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? encodedTodos = prefs.getString(_todosKey);
      if (encodedTodos != null) {
        final List<dynamic> decodedTodos = json.decode(encodedTodos);
        todos.value =
            decodedTodos.map((item) => TodoModel.fromJson(item)).toList();
      }
    } catch (e) {
      debugPrint('Error loading todos: $e');
      // You might want to show an error message to the user here
    }
  }
}
