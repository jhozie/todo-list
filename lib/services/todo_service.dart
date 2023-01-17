import 'package:flutter/cupertino.dart';
import 'package:todo_list/database/todo_database.dart';
import 'package:todo_list/models/todo.dart';

import '../models/user.dart';

class TodoService with ChangeNotifier {
  List<Todo> _todo = [];
  List<Todo> _searchTodo = [];
  List<Todo> get searchTodo => _searchTodo;

  List<Todo> get todo => _todo;

  searchTodo1(String search) {
    _searchTodo = _todo;

    if (search.isEmpty) {
      _searchTodo = _todo;
    } else {
      if (search.isEmpty) {
        _searchTodo = _todo;
      } else {
        _searchTodo = _todo
            .where((todoTitle) =>
                todoTitle.title.toLowerCase().contains(search.toLowerCase()))
            .toList();
      }
    }
    notifyListeners();
  }

  Future<String> getTodos(String username) async {
    try {
      _todo = await TodoDataBase.instance.getTodos(username);
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    return 'OK';
  }

  Future<String> deleteTodo(Todo todo) async {
    try {
      await TodoDataBase.instance.deleteTodo(todo);
    } catch (e) {
      return e.toString();
    }
    String result = await getTodos(todo.username);
    return result;
  }

  Future<String> createTodo(Todo todo) async {
    try {
      await TodoDataBase.instance.createTodo(todo);
    } catch (e) {
      return e.toString();
    }
    String result = await getTodos(todo.username);
    return result;
  }

  Future<String> toggleTodoDone(Todo todo) async {
    try {
      await TodoDataBase.instance.toggleTodoDone(todo);
    } catch (e) {
      return e.toString();
    }
    String result = await getTodos(todo.username);
    return result;
  }
}
