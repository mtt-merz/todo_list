import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/app/models/todo.dart';
import 'package:todo_list/app/services/persistence/persistence_service.dart';

abstract class HomeCubitState {}

class Initialize extends HomeCubitState {}

class Loaded extends HomeCubitState {
  final List<Todo> todos;

  Loaded(this.todos);
}

class HomeCubit extends Cubit<HomeCubitState> {
  late final PersistenceService _persistence;

  HomeCubit() : super(Initialize()) {
    GetIt.I.isReady<PersistenceService>().then((_) async {
      _persistence = GetIt.I<PersistenceService>();
      final objects = await _persistence.getAllJson('todos');
      _todos = objects.map((json) => Todo.fromJson(json)).toList();

      emit(Loaded(_todos));
    });
  }

  late final List<Todo> _todos;

  void addTodo() {
    final todo = Todo(
      title: 'TODO ${_todos.length}',
      description: 'description',
    );
    _todos.add(todo);
    _persistence.insertJson('todos', todo.id, todo.toJson());

    emit(Loaded([..._todos]));
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);
    _persistence.removeFromId('todos', todo.id);

    emit(Loaded([..._todos]));
  }
}
