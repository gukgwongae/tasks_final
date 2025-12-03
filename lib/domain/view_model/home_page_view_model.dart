import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasks/data/model/to_do_model.dart';
import 'package:tasks/domain/repository/to_do_repository.dart';
part 'home_page_view_model.g.dart';

@riverpod
class HomePageViewModel extends _$HomePageViewModel {
  final ToDoRepository toDoRepository = ToDoRepository();

  DocumentSnapshot? lastDoc;
  bool isLoading = false;

  @override
  Future<List<ToDoModel>> build() async {
    lastDoc = null;
    final result = await toDoRepository.getToDos();
    lastDoc = result['lastDoc'];
    return result['todos'];
  }

  Future<void> fetchMoreTodos() async {
    if (isLoading) return;
    isLoading = true;
    final result = await toDoRepository.getToDos(lastDoc: lastDoc);
    final moreTodos = result['todos'] as List<ToDoModel>;
    if (moreTodos.isNotEmpty) {
      state = AsyncData([...state.value!, ...moreTodos]);
      lastDoc = result['lastDoc'] as DocumentSnapshot?;
    }
    isLoading = false;
  }

  Future<void> refreshTodos() async {
    lastDoc = null;
    state = const AsyncValue.loading();
    final result = await toDoRepository.getToDos();
    lastDoc = result['lastDoc'];
    state = AsyncData(result['todos'] as List<ToDoModel>);
  }

  Future<void> addTodo({required ToDoModel toDo}) async {
    state = AsyncValue.loading();
    state = AsyncData([...state.value!, toDo]);

    await toDoRepository.addToDo(toDo);
  }

  Future<void> toggleFavorite({
    required String id,
    required bool isFavorite,
  }) async {
    ToDoModel? updatedTodo;
    state = state.whenData((todos) {
      final todo = todos.firstWhere((element) => element.id == id);
      updatedTodo = todo.copyWith(isFavorite: isFavorite);
      return [
        for (final t in todos)
          if (t.id == id) updatedTodo! else t,
      ];
    });
    if (updatedTodo != null) {
      await toDoRepository.updateToDo(updatedTodo!);
    }
  }

  Future<void> toggleDone({required String id, required bool isDone}) async {
    ToDoModel? updatedTodo;
    state = state.whenData((todos) {
      final todo = todos.firstWhere((element) => element.id == id);
      updatedTodo = todo.copyWith(isDone: isDone);
      return [
        for (final t in todos)
          if (t.id == id) updatedTodo! else t,
      ];
    });
    if (updatedTodo != null) {
      await toDoRepository.updateToDo(updatedTodo!);
    }
  }

  Future<void> deleteTodo({required String id}) async {
    await toDoRepository.deleteToDo(id);
    state = AsyncData(
      state.value!.where((element) => element.id != id).toList(),
    );
  }
}
