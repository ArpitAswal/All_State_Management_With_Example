// Events
part of 'todo_bloc.dart';

// These are the different actions that can be performed on the TodoBloc
abstract class TodoEvent {}

// Event to load the todo items
class LoadTodoEvent extends TodoEvent {}

// Event to add a new todo item
class AddTodoEvent extends TodoEvent {
  final String title;
  AddTodoEvent({required this.title});
}

// Event to toggle the completion status of a todo item
class ToggleTodoEvent extends TodoEvent {
  final int index;
  ToggleTodoEvent({required this.index});
}

// Event to remove a todo item
class DeleteTodoEvent extends TodoEvent {
  final int index;
  DeleteTodoEvent({required this.index});
}
