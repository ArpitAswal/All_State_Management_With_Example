import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';

class BlocTodo extends StatelessWidget {
  const BlocTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bloc Todo List')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onSubmitted: (text) {
                context.read<TodoBloc>().add(AddTodoEvent(title: text));
              },
              decoration: const InputDecoration(hintText: 'Add a todo'),
            ),
            Expanded(
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  if (state is TodoLoaded) {
                    return ListView.builder(
                      itemCount: state.todos.length,
                      itemBuilder: (context, index) {
                        final todo = state.todos[index];
                        return ListTile(
                          title: Text(todo.title),
                          leading: Checkbox(
                            value: todo.isDone,
                            onChanged: (value) => context
                                .read<TodoBloc>()
                                .add(ToggleTodoEvent(index: index)),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => context
                                .read<TodoBloc>()
                                .add(DeleteTodoEvent(index: index)),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No todos yet'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
