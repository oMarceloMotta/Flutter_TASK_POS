import 'dart:convert';

import 'package:task_pk_ex_pos_flutter/task_pk.dart';
import 'package:my_tasks/repositories/tasks_repository.dart';

class TasksService {
  final TasksRepository _tasksRepository = TasksRepository();

  Future<List<Task>> list() async {
    try {
      return await _tasksRepository.list();
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<void> insert(Task task) async {
    try {
      await _tasksRepository.insert(task);
    } catch (err) {
      throw Exception("Problemas ao inserir produto.");
    }
  }

  Future<void> update(String id, Task task) async {
    try {
      await _tasksRepository.update(id, task);
    } catch (err) {
      throw Exception("Problemas ao inserir produto.");
    }
  }

  Future<void> delete(String id) async {
    try {
      await _tasksRepository.delete(id);
    } catch (err) {
      throw Exception("Problemas ao excluir produto.");
    }
  }
}
