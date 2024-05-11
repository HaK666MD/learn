import 'package:flutter/material.dart';
import 'package:learn/domain/models/todo_model.dart';
import 'package:learn/ui/screens/todo/todo_provider.dart';
import 'package:learn/config/router/app_router.dart';
import 'package:learn/utils/date_time_extension.dart';
import 'package:provider/provider.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => globalNavigator.currentState!.pushNamed(Routes.todoAddScreen),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: todoProvider.todoList.isEmpty
            ? const Center(
                child: Text('No Todos'),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    Todo todo = todoProvider.todoList[index];
                    return Dismissible(
                      key: Key(DateTime.now().millisecond.toString()),
                      onDismissed: (direction) => todoProvider.onRemove(todo),
                      child: Card(
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(todo.title),
                              Text((todo.createdAt.format())),
                            ],
                          ),
                          subtitle: Text(todo.desc),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8.0,
                  ),
                  itemCount: todoProvider.todoList.length,
                ),
              ),
      ),
    );
  }
}
