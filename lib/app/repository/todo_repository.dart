import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:todo_list/app/models/todo.dart';
import 'package:todo_list/app/services/persistence/persistence_service.dart';

class TodoRepository {
  late final PersistenceService _persistence;

  late List<Todo> _todos;

  TodoRepository() {
    GetIt.I.isReady<PersistenceService>().then((_) async {
      _persistence = GetIt.I<PersistenceService>();

      final objects = await _persistence.getAllJson('todos');
      _todos = objects.map((json) => Todo.fromJson(json)).toList();

      _todosStreamController.add(_todos);
    });
  }

  final StreamController<List<Todo>> _todosStreamController = StreamController.broadcast();

  Stream<List<Todo>> get todosStream => _todosStreamController.stream;

  void insert(Todo todo) {
    _todos.add(todo);
    _todosStreamController.add(_todos);

    _persistence.insertJson('todos', todo.id, todo.toJson());
  }

  void remove(Todo todo) {
    _todos.remove(todo);
    _todosStreamController.add(_todos);

    _persistence.removeFromId('todos', todo.id);
  }

  int get todosNumber => _todos.length;
}
