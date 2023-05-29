import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../ models/task.dart';
import '../screens/home.screen.dart';
import '../services/tasks_service.dart';

class FormTask extends StatefulWidget {
  final String? paramId;
  final String? paramName;
  final String? paramLocation;
  final bool? paramStatus;

  const FormTask({
    Key? key,
    this.paramId,
    this.paramName,
    this.paramLocation,
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
    Task task = Task(_name.text, _statusNotifier.value, _location.text);
    if (id != '') {
      _service.update(id, task);
    } else {
      _service.insert(task);
    }
    Navigator.pop(context); // Voltar à tela anterior

    Navigator.pushReplacement(
      // Substituir a tela atual
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  void onDelete() {
    Task task = Task(_name.text, _statusNotifier.value, _location.text);
    _service.delete(id);
    Navigator.pop(context); // Voltar à tela anterior

    Navigator.pushReplacement(
      // Substituir a tela atual
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  Widget ButtonDelete() {
    if (id != '') {
      return ElevatedButton(
        onPressed: onDelete,
        child: Text("Deletar"),
        style: ElevatedButton.styleFrom(
          primary: Colors.red, // Cambia el color del botón a rojo
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
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erro ao obter localização');
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
                    child: Text("Salvar"),
                  ),
                  ButtonDelete(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
