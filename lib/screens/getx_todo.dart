import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_management_concept/controller/todo_controller.dart';

class GetXTodo extends StatelessWidget {
  final TodoController controller = Get.put(TodoController());

  GetXTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GetX ToDo List')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onSubmitted: (text) {
                controller.addTodo(text);
              },
              decoration: const InputDecoration(hintText: 'Add a todo'),
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.todos.length,
                    itemBuilder: (context, index) {
                      final todo = controller.todos[index];
                      return ListTile(
                        title: Text(todo.title),
                        leading: Checkbox(
                          value: todo.isDone,
                          onChanged: (value) => controller.toggleTodo(index),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => controller.removeTodo(index),
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
