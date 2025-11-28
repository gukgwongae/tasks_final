import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tasks/core/app_theme.dart';
import 'package:tasks/core/firebase_options.dart';
import 'package:tasks/core/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}


// pull to refresh, infinite scrolling 구현
// 스크롤에 디바운싱 적용

// 반응형 ui로 수정

// 나만의 기능 -






// ------------------------------------------

// go router 이용해 페이지 전환 - 패키지
// 시작 페이지 홈, 홈 <-> 디테일페이지, ? <-> 에러페이지 수정완료

// hero 위젯으로 상세화면 전환 효과 부여
// title 수정 완료 (근데 뭔가 어색하게 진행됨 child속성의 값들을 같게 해도 애니메이션이 이상함)
