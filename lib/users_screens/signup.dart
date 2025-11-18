import 'package:flutter/material.dart';
import 'widgets/app_button.dart';
import 'widgets/app_text_field.dart';
import 'widgets/page_title.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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

            const AppTextField(label: '이름'),
            const SizedBox(height: 12),

            Row(
              children: [
                const Expanded(child: AppTextField(label: '전화번호')),
                const SizedBox(width: 8),
                AppButton(
                  text: '인증',
                  onPressed: () {},
                  fullWidth: false,
                  height: 45,
                ),
              ],
            ),

            const SizedBox(height: 12),
            const AppTextField(label: '이메일'),
            const SizedBox(height: 12),
            const AppTextField(label: '비밀번호', obscure: true),

            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton(text: '완료', onPressed: () {}, fullWidth: false),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
