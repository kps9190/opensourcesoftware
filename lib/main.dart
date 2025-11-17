// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import './screens/applaunch/loading_screen.dart';

import './screens/search/category_and_price.dart';
import 'screens/search/map_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await FlutterNaverMap().init(clientId: 'gflswadwll');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '테이블링',
      theme: ThemeData(useMaterial3: true),

      // 최초 화면
      home: const LoadingScreen(),

      // 네비게이션용 라우트 등록
      routes: {
        '/categoryandprice': (context) => const CategoryAndPriceScreen(),
        '/maps': (context) => const MapScreen(),
        // '/mypage': (context) => const MyPageScreen(),
      },
    );
  }
}
