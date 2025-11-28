import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tasks/core/app_theme.dart';
import 'package:tasks/domain/view_model/home_page_view_model.dart';

class DetailPage extends ConsumerWidget {
  const DetailPage({super.key, required this.toDoId});
  final String toDoId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toDo = ref.watch(
      homePageViewModelProvider.select(
        (viewModel) =>
            viewModel.value?.firstWhere((element) => element.id == toDoId),
      ),
    );

    return Scaffold(
      backgroundColor: vrc(context).background300,
      appBar: AppBar(
        backgroundColor: vrc(context).background200,
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: Icon(Icons.arrow_back_rounded),
        ),
        actions: [
          InkWell(
            onTap: () {
              ref
                  .read(homePageViewModelProvider.notifier)
                  .toggleFavorite(id: toDoId, isFavorite: !toDo.isFavorite);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              width: 48,
              height: 48,
              child: Center(
                child: Icon(
                  toDo!.isFavorite
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  size: 24,
                  color: vrc(context).textColor200,
                ),
              ),
            ),
          ),
        ],
        title: Hero(
          tag: 'todo-title-${toDo.id}',
          child: Container(
            color: Colors.transparent,
            child: Text(
              toDo.title,
              style: TextStyle(
                color: vrc(context).textColor200,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: toDo.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: vrc(context).background300,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Icon(
                  Icons.short_text_rounded,
                  size: 24,
                  color: vrc(context).textColor200,
                ),
                Expanded(
                  child: Text(
                    toDo.description ?? '세부정보 추가',
                    style: TextStyle(
                      color: vrc(context).textColor200,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
