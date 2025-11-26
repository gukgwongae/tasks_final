import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tasks/core/app_theme.dart';
import 'package:tasks/ui/widget/add_to_do_dialog.dart';
import 'package:tasks/ui/widget/no_to_do.dart';
import 'package:tasks/ui/widget/to_do_view.dart';
import 'package:tasks/ui/widget/weather_info.dart';
import 'package:tasks/domain/view_model/home_page_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vrc(context).background300,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: vrc(context).background200,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            color: vrc(context).textColor200,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _TodoBody(title: title),
      bottomNavigationBar: WeatherInfo(),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: fxc(context).brandColor,
        shape: CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const AddToDoDialog(),
          );
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add_rounded, size: 24),
      ),
    );
  }
}

class _TodoBody extends ConsumerWidget {
  const _TodoBody({required this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(homePageViewModelProvider);
    return todos.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
      data: (items) => items.isEmpty
          ? NoToDo(title: title)
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, i) => ToDoView(toDo: items[i]),
              ),
            ),
    );
  }
}
