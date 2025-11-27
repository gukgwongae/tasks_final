import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tasks/core/app_theme.dart';
import 'package:tasks/core/firebase_options.dart';
import 'package:tasks/ui/home_page/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const HomePage(title: '스파르타`s Tasks'),
    );
  }
}

// 날씨 위젯 제거?

// go router 이용해 페이지 전환 - 패키지
// 터치 버튼에 디바운싱 적용 - 패키지
// hero 위젯으로 상세화면 전환 효과 부여

// pull to refresh, infinite scrolling 구현
// 반응형 ui로 수정
// 테스트 코드 작성 (안할듯?)
// 나만의 기능 -
