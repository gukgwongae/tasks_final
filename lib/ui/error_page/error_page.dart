import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Center(
        child: Column(
          children: [
            Text('error 홈으로 돌아가기'),
            GestureDetector(
              onTap: () {
                context.go('/');
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
