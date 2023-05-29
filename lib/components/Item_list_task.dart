import 'package:flutter/material.dart';
import 'package:my_tasks/routes/routes.path.dart';

import '../ models/task.dart';
import '../screens/task_form_screen.dart';
import '../services/tasks_service.dart';

class ItemListTask extends StatelessWidget {
  const ItemListTask({
    Key? key,
    required this.task,
    required this.onTaskStatusChanged,
  }) : super(key: key);

  final Task task;
  final Function(bool) onTaskStatusChanged;
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.name),
      subtitle: Text(task.location),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: task.status,
            onChanged: (value) {
              onTaskStatusChanged(value ?? false);
              TasksService().update(task.id.toString(), task);
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskFormScreen(
                    paramId: task.id.toString(),
                    paramName: task.name,
                    paramLocation: task.location,
                    paramStatus: task.status,
                  ),
                ),
              )
            },
          ),
        ],
      ),
    );
  }
}
