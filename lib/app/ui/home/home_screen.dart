import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/app/models/todo.dart';
import 'package:todo_list/app/ui/home/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeCubit cubit = HomeCubit();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('TODO List'), centerTitle: true),
        body: BlocBuilder(
            bloc: cubit,
            builder: (context, state) {
              if (state is Initialize) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is Loaded) {
                final todos = state.todos;
                return ListView(children: todos.map(buildTodoTile).toList());
              }

              return Container();
            }),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => cubit.addTodo(),
        ),
      );

  Widget buildTodoTile(Todo todo) => ListTile(
        title: Text(todo.title),
        subtitle: todo.description != null ? Text(todo.description!) : null,
        trailing: IconButton(
          icon: const Icon(Icons.done),
          onPressed: () => cubit.removeTodo(todo),
        ),
      );
}