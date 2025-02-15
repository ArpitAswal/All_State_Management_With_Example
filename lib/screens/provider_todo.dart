import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_concept/provider/todo_provider.dart';

class ProviderTodo extends StatelessWidget {
  const ProviderTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Provider ToDo List')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onSubmitted: (text) {
                context.read<TodoProvider>().addTodo(text);
              },
              decoration: const InputDecoration(hintText: 'Add a todo'),
            ),
            Expanded(
              child: Consumer<TodoProvider>(
                builder: (context, model, child) => ListView.builder(
                  itemCount: model.todos.length,
                  itemBuilder: (context, index) {
                    final todo = model.todos[index];
                    return ListTile(
                      title: Text(todo.title),
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (value) => model.toggleTodo(index),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => model.deleteTodo(index),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
