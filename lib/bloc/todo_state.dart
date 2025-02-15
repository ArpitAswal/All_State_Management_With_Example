// States
part of 'todo_bloc.dart';

abstract class TodoState {}

class TodoInitial extends TodoState {}

// Add an loading data state to handle potential database errors
class TodoLoaded extends TodoState {
  final List<TodoDBModel> todos;
  TodoLoaded({required this.todos});
}

// Add an error state to handle potential database errors
class TodoError extends TodoState {
  final String message;
  TodoError(this.message);
}
