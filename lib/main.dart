import 'package:flutter/material.dart';
import 'package:my_tasks/routes/routes.path.dart';
import 'package:my_tasks/screens/home.screen.dart';
import 'package:my_tasks/screens/task_form_screen.dart';

void main () {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RoutesPath.HOME: (context) => Home(),
        RoutesPath.TASKFORMSCREEN: (context) => TaskFormScreen(),
      }
    );
  }
}
