import 'package:flutter/material.dart';

class ResponsiveView extends StatelessWidget {
  // 소형 태블릿, 폴드
  final Widget? tablet600;
  // 모바일 세로
  final Widget mobile;

  const ResponsiveView({super.key, required this.mobile, this.tablet600});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context).width;
    if (deviceWidth >= 600 && tablet600 != null) {
      return tablet600!;
    }
    return mobile;
  }
}
