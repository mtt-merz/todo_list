import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/app/models/todo.dart';
import 'package:todo_list/app/repository/todo_repository.dart';

abstract class HomeCubitState {}

class Initialize extends HomeCubitState {}

class Loaded extends HomeCubitState {
  final List<Todo> todos;

  Loaded(this.todos);
}

class HomeCubit extends Cubit<HomeCubitState> {
  final TodoRepository _repository;

  HomeCubit(this._repository) : super(Initialize()) {
    _repository.todosStream.listen((todos) => emit(Loaded(todos)));
  }

  void addTodo() {
    final todo = Todo(
      title: 'TODO ${_repository.todosNumber}',
      description: 'description',
    );

    _repository.insert(todo);
  }

  void removeTodo(Todo todo) => _repository.remove(todo);
}
