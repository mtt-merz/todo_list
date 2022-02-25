import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/app/services/persistence/persistence_service.dart';
import 'package:todo_list/app/services/persistence/sembast_wrapper.dart';
import 'package:todo_list/app/ui/home/home_screen.dart';

void main() {
  GetIt.I.registerSingletonAsync<PersistenceService>(SembastWrapper.initialize);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: HomeScreen(),
      );
}
