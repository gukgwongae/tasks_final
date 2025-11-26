import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks/data/model/to_do_model.dart';

class ToDoRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addToDo(ToDoModel toDo) async {
    await _db.collection('todos').doc(toDo.id).set(toDo.toJson());
  }

  Future<void> updateToDo(ToDoModel toDo) async {
    await _db.collection('todos').doc(toDo.id).update(toDo.toJson());
  }

  Future<void> deleteToDo(String id) async {
    await _db.collection('todos').doc(id).delete();
  }

  Future<List<ToDoModel>> getToDos() async {
    final snapshot = await _db.collection('todos').get();
    return snapshot.docs.map((doc) => ToDoModel.fromJson(doc.data())).toList();
  }
}
