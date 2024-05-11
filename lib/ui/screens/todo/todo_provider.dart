import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:learn/domain/models/todo_model.dart';
import 'package:learn/config/router/app_router.dart';

class TodoProvider extends ChangeNotifier {
  bool isButtonEnabled = false;

  final TextEditingController _titleController = TextEditingController();
  TextEditingController get titleController => _titleController;

  final TextEditingController _descController = TextEditingController();
  TextEditingController get descController => _descController;

  final List<Todo> _todoList = <Todo>[];
  UnmodifiableListView<Todo> get todoList => UnmodifiableListView(_todoList);

  bool get _isValid =>
      _titleController.text.isNotEmpty && _descController.text.isNotEmpty;

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descController.dispose();
  }

  void clear() {
    _titleController.clear();
    _descController.clear();
  }

  void validateFields() {
    isButtonEnabled = _isValid;
    notifyListeners();
  }

  void onAdd() {
    if (_isValid) {
      _todoList.add(
        Todo(
          title: _titleController.text.trim(),
          desc: _descController.text.trim(),
          createdAt: DateTime.now(),
        ),
      );
      clear();
      notifyListeners();
      globalNavigator.currentState!.pop();
    }
  }

  void onRemove(Todo todo) {
    _todoList.remove(todo);
    if (_todoList.isEmpty) {
      notifyListeners();
    }
  }
}
