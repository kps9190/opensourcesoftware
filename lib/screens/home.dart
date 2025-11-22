import 'package:flutter/material.dart';
import 'login.dart';
import 'user_edit.dart';
import 'user_history.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const UserEditScreen(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'DaHee님',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      size: 26,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 100),

              // 중앙 로그인 버튼
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('로그인해 주세요'),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const UserHistoryScreen(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('이용내역'),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
