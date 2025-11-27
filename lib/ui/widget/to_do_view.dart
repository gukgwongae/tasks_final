import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tasks/core/app_theme.dart';
import 'package:tasks/domain/view_model/home_page_view_model.dart';
import 'package:tasks/data/model/to_do_model.dart';

class ToDoView extends ConsumerWidget {
  const ToDoView({super.key, required this.toDo});
  final ToDoModel toDo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: vrc(context).background200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 12,
        children: [
          SizedBox(),
          InkWell(
            onTap: () => ref
                .read(homePageViewModelProvider.notifier)
                .toggleDone(id: toDo.id, isDone: !toDo.isDone),
            child: SizedBox(
              width: 40,
              height: 40,
              child: Center(
                child: Icon(
                  toDo.isDone
                      ? Icons.check_circle_rounded
                      : Icons.circle_outlined,
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                context.go('/todo/${toDo.id}');
              },
              child: Text(
                toDo.title,
                style: TextStyle(
                  color: vrc(context).textColor200,
                  fontSize: 16,
                  decoration: toDo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () => ref
                    .read(homePageViewModelProvider.notifier)
                    .toggleFavorite(id: toDo.id, isFavorite: !toDo.isFavorite),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: Icon(
                      toDo.isFavorite
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await ref
                      .read(homePageViewModelProvider.notifier)
                      .deleteTodo(id: toDo.id);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 48,
                  height: 48,
                  child: Center(
                    child: Icon(
                      Icons.delete_rounded,
                      size: 24,
                      color: vrc(context).textColor200,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
