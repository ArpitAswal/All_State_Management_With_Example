import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../adapter/hive_todo_model.dart';

class TodoProvider extends ChangeNotifier {
  // Hive box to store todos
  late Box<HiveTodoModel> _box;

  // List to hold todos in memory
  List<HiveTodoModel> _todos = [];

  // Getter for todos
  List<HiveTodoModel> get todos => _todos;

  TodoProvider() {
    _openBox();
  }

  // Open Hive box and load todos
  Future<void> _openBox() async {
    _box = Hive.box<HiveTodoModel>('todos');
    await _loadTodos();
  }

  // Load todos from Hive box
  Future<void> _loadTodos() async {
    _todos = _box.values.toList();
    notifyListeners();
  }

  // Add a new todo
  Future<void> addTodo(String title) async {
    final newTodo = HiveTodoModel(title: title);
    await _box.add(newTodo);
    await _loadTodos();
  }

  // Toggle todo completion status
  Future<void> toggleTodo(int index) async {
    if (index >= 0 && index < _todos.length) {
      final todo = _todos[index];
      todo.isDone = !todo.isDone;
      await _box.putAt(index, todo);
      await _loadTodos();
    }
  }

  // Delete a todo
  Future<void> deleteTodo(int index) async {
    if (index >= 0 && index < _todos.length) {
      await _box.deleteAt(index);
      await _loadTodos();
    }
  }
}
