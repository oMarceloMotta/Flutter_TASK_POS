import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'package:task_pk_ex_pos_flutter/task_pk.dart';

abstract class Repository {
  final _db = FirebaseFirestore.instance;
  final String _collection;
  final String collectionPath = 'tarefas';

  Repository(this._collection);

  Future<List<Task>> list() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final querySnapshot = await _db
        .collection(collectionPath)
        .doc(userId)
        .collection('task')
        .get();
    final taskList =
        querySnapshot.docs.map((doc) => Task.fromJson(doc.data())).toList();
    return taskList;
  }

  Future<void> insert(Task task) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final docRef =
        _db.collection(collectionPath).doc(userId).collection('task').doc();
    task.id = docRef.id;
    await docRef.set(task.toJson());
    _db.collection(_collection).add(task.toJson());
  }

  Future<Task> show(String id) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final docSnapshot = await _db
        .collection(collectionPath)
        .doc(userId)
        .collection('task')
        .doc(id)
        .get();

    if (docSnapshot.exists) {
      return Task.fromJson(docSnapshot.data()!);
    } else {
      return Task(
        name: '',
        status: false,
        location: '',
        datetime: DateTime.now(),
        id: '',
      );
    }
  }

  Future<void> update(String id, Task data) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final docRef =
        _db.collection(collectionPath).doc(userId).collection('task').doc(id);
    await docRef.update(data.toJson());
  }

  Future<void> delete(String id) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final docRef =
        _db.collection(collectionPath).doc(userId).collection('task').doc(id);
    await docRef.delete();
  }
}
