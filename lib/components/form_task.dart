import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:task_pk_ex_pos_flutter/task_pk.dart';
import '../screens/home.screen.dart';
import '../services/tasks_service.dart';
import 'package:intl/intl.dart';

class FormTask extends StatefulWidget {
  final String? paramId;
  final String? paramName;
  final String? paramLocation;
  final DateTime? dateTask;
  final bool? paramStatus;

  const FormTask({
    Key? key,
    this.paramId,
    this.paramName,
    this.paramLocation,
    this.dateTask,
    this.paramStatus,
  }) : super(key: key);

  @override
  State<FormTask> createState() => _FormTaskState();
}

class _FormTaskState extends State<FormTask> {
  final _name = TextEditingController();
  final _location = TextEditingController();
  final ValueNotifier<bool> _statusNotifier = ValueNotifier<bool>(false);
  final TasksService _service = TasksService();
  late Future<String> _locationFuture;
  late String id = '';
  late ValueNotifier<DateTime?> _dateTaskNotifier;

  @override
  void initState() {
    super.initState();
    id = widget.paramId ?? '';
    _name.text = widget.paramName ?? '';
    _location.text = widget.paramLocation ?? '';
    _statusNotifier.value = widget.paramStatus ?? false;
    _locationFuture = widget.paramLocation != null
        ? Future.value(widget.paramLocation!)
        : getLocation();
    _dateTaskNotifier = ValueNotifier<DateTime?>(widget.dateTask);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    );

    if (picked != null && picked != _dateTaskNotifier.value) {
      setState(() {
        _dateTaskNotifier.value = picked;
      });
    }
  }

  Future<String> getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return '';
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return '';
    }

    locationData = await location.getLocation();
    return "${locationData.latitude} : ${locationData.longitude}";
  }

  void onSubmit() {
    Task task = Task(
      name: _name.text,
      status: _statusNotifier.value,
      location: _location.text,
      datetime: _dateTaskNotifier.value,
    );
    if (id != '') {
      _service.update(id, task);
    } else {
      _service.insert(task);
    }
    Navigator.pop(context);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  void onDelete() {
    _service.delete(id);
    Navigator.pop(context); // Volver a la pantalla anterior

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  Widget buttonDelete() {
    if (id != '') {
      return ElevatedButton(
        onPressed: onDelete,
        child: const Text("Deletar"),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(
            255,
            99,
            104,
            205,
          ),
        ),
      );
    }
    return Container(); // Agregué un contenedor vacío en caso de que id sea nulo
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Nome da tarefa",
              ),
              controller: _name,
            ),
            FutureBuilder<String>(
              future: _locationFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(50.0),
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Text('Erro ao obter localização');
                } else {
                  _location.text = snapshot.data ?? '';
                  return TextField(
                    decoration: const InputDecoration(
                      labelText: "Localização",
                    ),
                    controller: _location,
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder<DateTime?>(
                    valueListenable: _dateTaskNotifier,
                    builder: (context, value, child) {
                      return Text(value != null
                          ? DateFormat('dd/MM/yyyy').format(value)
                          : '');
                    },
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text(_dateTaskNotifier.value == null
                        ? 'Selecionar uma data'
                        : 'Alterar Data'),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Text("Status"),
                ValueListenableBuilder<bool>(
                  valueListenable: _statusNotifier,
                  builder: (context, value, child) {
                    return Checkbox(
                      value: value,
                      onChanged: (newValue) {
                        _statusNotifier.value = newValue!;
                      },
                    );
                  },
                ),
              ],
            ),
            Center(
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: onSubmit,
                    child: const Text("Salvar"),
                  ),
                  buttonDelete(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
