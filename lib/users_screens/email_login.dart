import 'package:flutter/material.dart';
import 'package:flutter_fb/users_screens/signup.dart';
import 'widgets/app_button.dart';
import 'widgets/app_text_field.dart';
import 'widgets/page_title.dart';
import 'user_server_stub/user_login_stub.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final server = UserLoginStub();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('이메일과 비밀번호를 입력해주세요')));
      return;
    }

    final result = await server.loginUser(email, password);

    if (result['success']) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('${result['name']}님 로그인 성공')));
      // TODO: 로그인 성공 시 다음 화면으로 이동
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result['message'])));
    }
  }

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
            const PageTitle('이메일 로그인'),
            const SizedBox(height: 20),

            // 이메일 입력
            AppTextField(label: '이메일', controller: emailController),
            const SizedBox(height: 12),

            // 비밀번호 입력
            AppTextField(
              label: '비밀번호',
              obscure: true,
              controller: passwordController,
            ),
            const SizedBox(height: 25),

            // 로그인 버튼
            AppButton(text: '로그인', onPressed: _login),
            const SizedBox(height: 25),

            // 하단 옵션
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
