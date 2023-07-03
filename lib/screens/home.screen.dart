import 'package:flutter/material.dart';
import 'package:my_tasks/routes/routes.path.dart';
import 'package:my_tasks/screens/profile.screen.dart';

import '../components/list_task.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas!'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          },
        ),
      ),
      body: const Column(
        children: [
          ListTask(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(RoutesPath.TASKFORMSCREEN);
        },
      ),
    );
  }
}
