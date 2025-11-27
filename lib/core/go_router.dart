import 'package:go_router/go_router.dart';
import 'package:tasks/ui/detail_page/detail_page.dart';
import 'package:tasks/ui/error_page/error_page.dart';
import 'package:tasks/ui/home_page/home_page.dart';

final router = GoRouter(
  routes: [
    //
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(title: 'final tasks'),
      routes: [
        GoRoute(
          path: 'todo/:id',
          builder: (context, state) {
            final id = state.pathParameters['id'];
            if (id == null) {
              return const ErrorPage();
            }
            return DetailPage(toDoId: id);
          },
        ),
      ],
    ),
  ],
  initialLocation: '/',
  errorBuilder: (context, state) => const ErrorPage(),
);
