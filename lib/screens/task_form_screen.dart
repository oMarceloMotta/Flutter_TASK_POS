import 'package:flutter/material.dart';
import '../components/form_task.dart';

class TaskFormScreen extends StatelessWidget {
  final String? paramId;
  final String? paramName;
  final String? paramLocation;
  final bool? paramStatus;

  const TaskFormScreen({
    this.paramId,
    this.paramName,
    this.paramLocation,
    this.paramStatus,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Tarefa"),
        ),
      ),
      body: Column(
        children: [
          FormTask(
            paramId: paramId,
            paramName: paramName,
            paramLocation: paramLocation,
            paramStatus: paramStatus,
          ),
        ],
      ),
    );
  }
}
