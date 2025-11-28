import 'package:flutter/material.dart';
import 'package:tasks/core/responsive_view.dart';
import 'package:tasks/ui/home_page/home_page.dart';
import 'package:tasks/ui/detail_page/detail_page.dart';

class ResponsivePage extends StatefulWidget {
  const ResponsivePage({Key? key}) : super(key: key);

  @override
  State<ResponsivePage> createState() => _ResponsivePageState();
}

class _ResponsivePageState extends State<ResponsivePage> {
  String? selectedToDoId;

  @override
  Widget build(BuildContext context) {
    return ResponsiveView(
      mobile: HomePage(title: '이장수'),
      tablet600: Row(
        children: [
          HomePage(title: '이장수'),
          DetailPage(toDoId: selectedToDoId ?? '할 일을 선택해주세요'),
        ],
      ),
    );
  }
}
