import 'package:flutter/material.dart';
import 'signup.dart';

class InternalLoginScreen extends StatelessWidget {
  const InternalLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              ' 이메일로 로그인',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),

            const SizedBox(height: 13),

            // 이메일 입력
            const TextField(
              decoration: InputDecoration(
                hintText: '이메일 입력',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            // 비밀번호 입력
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: '비밀번호 입력',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            // 로그인 버튼
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD9D9D9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  '로그인',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // 이메일 찾기 / 비밀번호 재설정 / 회원가입
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('이메일 찾기', style: TextStyle(color: Colors.grey)),
                const SizedBox(width: 12),
                const Text('|', style: TextStyle(color: Colors.grey)),
                const SizedBox(width: 12),
                const Text('비밀번호 재설정', style: TextStyle(color: Colors.grey)),
                const SizedBox(width: 12),
                const Text('|', style: TextStyle(color: Colors.grey)),
                const SizedBox(width: 12),

                // 회원가입 이동
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      '회원가입',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
