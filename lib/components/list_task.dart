// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:my_tasks/services/tasks_service.dart';
import 'package:task_pk_ex_pos_flutter/task_pk.dart';

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
    tasks = await TasksService().list();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Task>> _fetchTasks() async {
      // Realize a nova requisição GET aqui
      return TasksService().list();
    }

    return tasks.isNotEmpty
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
}
