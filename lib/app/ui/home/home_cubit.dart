import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/app/models/todo.dart';

abstract class HomeCubitState {}

class Initialize extends HomeCubitState {}

class Loaded extends HomeCubitState {
  final List<Todo> todos;

  Loaded(this.todos);
}

class HomeCubit extends Cubit<HomeCubitState> {
  final List<Todo> _todos = [];

  HomeCubit() : super(Initialize()) {
    emit(Loaded([]));
  }

  void addTodo() {
    final todo = Todo(
      title: 'TODO ${_todos.length}',
      description: 'description',
    );
    _todos.add(todo);

    emit(Loaded([..._todos]));
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);
    emit(Loaded([..._todos]));
  }
}
