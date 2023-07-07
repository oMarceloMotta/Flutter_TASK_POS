import 'package:flutter/material.dart';
import 'package:my_tasks/routes/routes.path.dart';
import 'package:task_pk_ex_pos_flutter/task_pk.dart';
import '../providers/task_firestore_provider.dart';
import '../screens/task_form_screen.dart';
import 'package:provider/provider.dart';

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
              final taskProvider =
                  Provider.of<TaskFireStoreProvider>(context, listen: false);
              taskProvider.update(task);
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
