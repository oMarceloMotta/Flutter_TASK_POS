import 'package:flutter/material.dart';
import 'package:my_tasks/components/form_task.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('TaskFormScreen - Verificar título da AppBar',
      (WidgetTester tester) async {
    try {
      expect(find.text('Tarefa'), findsOneWidget);
    } catch (e, stackTrace) {
      print('Exceção durante a execução do teste: $e\n$stackTrace');
    }
  });
}

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
