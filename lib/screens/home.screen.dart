import 'package:flutter/material.dart';
import 'package:my_tasks/routes/routes.path.dart';

import '../components/list_task.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Tarefas!'),
        ),
      ),
      body: Column(children: const [
        ListTask(),
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(RoutesPath.TASKFORMSCREEN);
        },
      ),
    );
  }
}
