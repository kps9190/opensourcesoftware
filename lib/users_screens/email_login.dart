import 'package:flutter/material.dart';
import 'package:flutter_fb/users_screens/signup.dart';
import 'widgets/app_button.dart';
import 'widgets/app_text_field.dart';
import 'widgets/page_title.dart';

class EmailLoginScreen extends StatelessWidget {
  const EmailLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageTitle('이메일로 로그인'),
            const SizedBox(height: 20),

            const AppTextField(label: '이메일'),
            const SizedBox(height: 12),
            const AppTextField(label: '비밀번호', obscure: true),

            const SizedBox(height: 25),
            AppButton(text: '로그인', onPressed: () {}),

            const SizedBox(height: 25),
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignupScreen()),
                    );
                  },
                  child: const Text(
                    '회원가입',
                    style: TextStyle(color: Colors.grey),
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
