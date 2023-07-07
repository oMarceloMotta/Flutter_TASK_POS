// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:my_tasks/providers/task_firestore_provider.dart';
import 'package:task_pk_ex_pos_flutter/task_pk.dart';
import 'package:provider/provider.dart';

import 'Item_list_task.dart';

class ListTask extends StatefulWidget {
  const ListTask({Key? key}) : super(key: key);

  @override
  State<ListTask> createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
  List<Task> tasks = [];
  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    TaskFireStoreProvider taskProvider =
        Provider.of<TaskFireStoreProvider>(context, listen: false);
    tasks = await taskProvider.list();
    setState(() {});
  }
  Future<List<Task>> _fetchTasks() async {
    TaskFireStoreProvider taskProvider =
        Provider.of<TaskFireStoreProvider>(context, listen: false);
    return await taskProvider.list();

    //return TasksService().list();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: _fetchTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Task>? tasks = snapshot.data;
          return tasks!.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return ItemListTask(
                        task: tasks[index],
                        onTaskStatusChanged: (value) {
                          tasks[index].status = value;
                          setState(() {});
                        },
                      );
                    },
                  ),
                )
              : const Center(child: Text("Não há tasks cadastradas"));
        }
      },
    );
  }
}
