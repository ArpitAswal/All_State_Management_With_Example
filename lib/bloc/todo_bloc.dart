// Import necessary packages
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_concept/model/todo_model.dart';
import 'package:sqflite/sqflite.dart';

// Import event and state files
part 'todo_event.dart';
part 'todo_state.dart';

// TodoBloc class that extends Bloc<TodoEvent, TodoState>
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  // Database instance
  late Database _database;

  // Constructor
  TodoBloc() : super(TodoInitial()) {
    // Open the database when the Bloc is created
    _openDatabase();
    // Register event handlers
    on<LoadTodoEvent>(_onLoadEvent);
    on<AddTodoEvent>(_onAddEvent);
    on<ToggleTodoEvent>(_onToggleEvent);
    on<DeleteTodoEvent>(_onDeleteEvent);
  }

  // Handler for AddTodoEvent
  Future<void> _onAddEvent(AddTodoEvent event, Emitter<TodoState> emit) async {
    // Insert new todo into the database
    final id =
        await _database.insert('todos', {'title': event.title, 'isDone': 0});
    // Create a TodoDBModel instance with the new todo
    final todo = TodoDBModel(id: id, title: event.title, isDone: false);

    // Update the state based on the current state
    if (state is TodoLoaded) {
      final todos = (state as TodoLoaded).todos;
      todos.add(todo);
      emit(TodoLoaded(todos: todos));
    } else {
      emit(TodoLoaded(todos: [todo]));
    }
  }

  // Handler for ToggleTodoEvent
  Future<void> _onToggleEvent(
      ToggleTodoEvent event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      final todos = (state as TodoLoaded).todos;
      // Toggle the isDone status of the todo at the given index
      todos[event.index] = todos[event.index].copyWith(
        isDone: !todos[event.index].isDone,
      );
      // Update the todo in the database
      await _database.update(
          'todos', {'isDone': todos[event.index].isDone ? 1 : 0},
          where: 'id = ?', whereArgs: [todos[event.index].id]);
      // Emit new state with updated todos
      emit(TodoLoaded(todos: todos));
    }
  }

  // Handler for DeleteTodoEvent
  Future<void> _onDeleteEvent(
      DeleteTodoEvent event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      final todos = (state as TodoLoaded).todos;
      final todoToDelete = todos[event.index];
      // Delete the todo from the database
      await _database
          .delete('todos', where: 'id = ?', whereArgs: [todoToDelete.id]);
      // Remove the todo from the list
      todos.removeAt(event.index);
      // Emit new state with updated todos
      emit(TodoLoaded(todos: todos));
    }
  }

  // Method to open the database
  Future<void> _openDatabase() async {
    _database = await openDatabase('todo_database.db', version: 1,
        onCreate: (Database db, int version) async {
      // Create the todos table if it doesn't exist
      await db.execute('''
          CREATE TABLE todos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            isDone INTEGER
          )
          ''');
    });
    // Load initial data after opening the database
    add(LoadTodoEvent());
  }

  // Handler for LoadTodoEvent
  FutureOr<void> _onLoadEvent(
      LoadTodoEvent event, Emitter<TodoState> emit) async {
    // Load initial data from database
    final maps = await _database.query('todos');
    final todos = maps.map((map) => TodoDBModel.fromMap(map)).toList();
    // Emit new state with loaded todos
    emit(TodoLoaded(todos: todos));
  }
}
