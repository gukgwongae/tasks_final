import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasks/data/model/to_do_model.dart';
import 'package:tasks/domain/repository/to_do_repository.dart';

part 'home_page_view_model.g.dart';

@riverpod
class HomePageViewModel extends _$HomePageViewModel {
  final ToDoRepository toDoRepository = ToDoRepository();

  @override
  Future<List<ToDoModel>> build() async {
    return await toDoRepository.getToDos();
  }

  Future<void> addTodo({required ToDoModel toDo}) async {
    state = AsyncValue.loading();
    state = AsyncData([...state.value!, toDo]);

    Map<String, dynamic> json = toDo.toJson();

    final a = json["isD0ne"];
    // toDo.
    final b = toDo.isDone;

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
