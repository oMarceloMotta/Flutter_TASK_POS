import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_tasks/%20models/task.dart';
import 'package:my_tasks/repositories/tasks_repository.dart';

class TasksService {
  final TasksRepository _tasksRepository = TasksRepository();

  Future<List<Task>> list() async {
    try {
      Response response = await _tasksRepository.list();
      Map<String, dynamic>? json = jsonDecode(response.body);
      return Task.listFromJson(json);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<Map<String, dynamic>> insert(Task task) async {
    try {
      String json = jsonEncode(task.toJson());
      Response response = await _tasksRepository.insert(json);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (err) {
      throw Exception("Problemas ao inserir produto.");
    }
  }

  Future<Map<String, dynamic>> update(String id, Task task) async {
    try {
      String json = jsonEncode(task.toJson());
      Response response = await _tasksRepository.update(id, json);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (err) {
      throw Exception("Problemas ao inserir produto.");
    }
  }

  Future<bool> delete(String id) async {
    try {
      Response response = await _tasksRepository.delete(id);
      return response.statusCode == 200;
    } catch (err) {
      throw Exception("Problemas ao excluir produto.");
    }
  }
}
