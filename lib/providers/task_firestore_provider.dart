import 'package:flutter/material.dart';
import 'package:my_tasks/services/tasks_service.dart';
import 'package:task_pk_ex_pos_flutter/task_pk.dart';

class TaskFireStoreProvider with ChangeNotifier {
  List<Task> tasks = [];
  static final _service = TasksService();

  Future<List<Task>> list() async {
    tasks = await _service.list();
    return tasks;
  }

  Future<void> insert(Task task) async {
    await _service.insert(task);
    tasks.add(task);
    notifyListeners();
  }

  Future<void> update(Task task) async {
    final index = tasks.indexWhere((item) => item.id == task.id);
    if (index != -1) {
      tasks[index] = task;
      await _service.update(task.id as String, task);
      notifyListeners();
    }
  }

  Future<void> remove(Task task) async {
    await _service.delete(task.id.toString());
    tasks.remove(task);
    notifyListeners();
  }
}
