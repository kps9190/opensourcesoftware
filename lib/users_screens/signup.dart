// users_screens/signup.dart
import 'package:flutter/material.dart';
import 'widgets/app_button.dart';
import 'widgets/app_text_field.dart';
import 'widgets/page_title.dart';
import 'user_server_stub/user_login_stub.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreen();
}

class _SignupScreen extends State<SignupScreen> {
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // 싱글톤을 사용하므로 어디서든 같은 인스턴스를 참조합니다.
  final server = UserLoginStub();

  void _onSignup() async {
    final name = nameController.text.trim();
    final phoneNumber = phoneNumberController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty ||
        phoneNumber.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("모든 정보를 입력해주세요")));
      return;
    }

    final res = await server.registerUser(name, phoneNumber, email, password);

    if (res['success']) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("회원가입 성공!")));

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(res['message'])));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
            const PageTitle('회원가입'),
            const SizedBox(height: 13),

            AppTextField(label: '이름', controller: nameController),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: '전화번호',
                    controller: phoneNumberController,
                  ),
                ),
                const SizedBox(width: 8),
                AppButton(
                  text: '인증',
                  onPressed: () async {
                    // 예: 인증번호 요청 (stubbing)
                    final res = await server.sendVerifyCode(
                      phoneNumberController.text.trim(),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("인증번호: ${res['code']}")),
                    );
                  },
                  fullWidth: false,
                  height: 45,
                ),
              ],
            ),

            const SizedBox(height: 12),

            AppTextField(label: '이메일', controller: emailController),

            const SizedBox(height: 12),

            AppTextField(
              label: '비밀번호',
              obscure: true,
              controller: passwordController,
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton(text: '완료', onPressed: _onSignup, fullWidth: false),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
