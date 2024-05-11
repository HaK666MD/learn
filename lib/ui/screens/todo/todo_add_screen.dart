import 'package:flutter/material.dart';
import 'package:learn/ui/screens/todo/todo_provider.dart';
import 'package:provider/provider.dart';
import 'package:learn/config/router/app_router.dart';

class TodoAddScreen extends StatelessWidget {
  const TodoAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return PopScope(
      onPopInvoked: (bool pop) {
        if (pop) todoProvider.clear();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Todo'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              todoProvider.clear();
              globalNavigator.currentState!.pop();
            },
          ),
        ),
        body: SafeArea(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: todoProvider.titleController,
                    decoration: const InputDecoration(labelText: 'Todo title'),
                    onChanged: (value) => todoProvider.validateFields(),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: todoProvider.descController,
                    decoration: const InputDecoration(labelText: 'Todo desc'),
                    onChanged: (value) => todoProvider.validateFields(),
                    maxLines: null,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  ElevatedButton(
                    onPressed: todoProvider.isButtonEnabled
                        ? todoProvider.onAdd
                        : null,
                    child: const Text('Add Todo'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
