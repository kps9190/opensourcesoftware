import 'package:flutter/material.dart';
import '../users_screens/widgets/app_text_field.dart';

class BusinessSignup extends StatelessWidget {
  const BusinessSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '사업체 등록',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 13),

            const AppTextField(label: '이름'),
            const SizedBox(height: 12),

            Row(
              children: [
                const Expanded(child: AppTextField(label: '전화번호')),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: () {}, child: const Text('인증')),
              ],
            ),
            const SizedBox(height: 12),

            const AppTextField(label: '이메일'),
            const SizedBox(height: 12),

            const AppTextField(label: '사업체 번호'),
            const SizedBox(height: 12),

            const AppTextField(label: '주소'),
            const SizedBox(height: 12),

            const AppTextField(label: '비밀번호', obscure: true),
            const SizedBox(height: 12),

            const AppTextField(label: '사업체 간략 소개'),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('등록 요청하기')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
