import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import './screen/splash_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    demoProjectId: "demo-opensourcesoftware",
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

      // 스플래시 화면
      home: const SplashScreen(),
    );
  }
}