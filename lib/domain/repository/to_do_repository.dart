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

  DocumentSnapshot? getLastDoc(QuerySnapshot snapshot) {
    return snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
  }

  Future<Map<String, dynamic>> getToDos({DocumentSnapshot? lastDoc}) async {
    var query = _db
        .collection('todos')
        .orderBy('createdAt', descending: true)
        .limit(15);
    if (lastDoc != null) {
      query = query.startAfterDocument(lastDoc);
    }
    final snapshot = await query.get();
    final todos = snapshot.docs
        .map((doc) => ToDoModel.fromJson(doc.data()))
        .toList();
    return {
      'todos': todos,
      'lastDoc': snapshot.docs.isNotEmpty ? snapshot.docs.last : null,
    };
  }
}
