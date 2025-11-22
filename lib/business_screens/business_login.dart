import 'package:flutter/material.dart';
import '../users_screens/widgets/app_text_field.dart';
import 'package:flutter_fb/business_screens/business_signup.dart';
import 'package:flutter_fb/business_screens/business_home.dart';
import './business_server_stub/business_login_stub.dart';

import '../users_screens/widgets/page_title.dart'; // PageTitle import 필요 (경로는 프로젝트에 맞게)

class BusinessLogin extends StatefulWidget {
  const BusinessLogin({super.key});

  @override
  State<BusinessLogin> createState() => _BusinessLoginState();
}

class _BusinessLoginState extends State<BusinessLogin> {
  final businessNumberController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    businessNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final businessNumber = businessNumberController.text.trim();
    final password = passwordController.text.trim();

    if (businessNumber.isEmpty || password.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("사업자번호와 비밀번호를 입력해주세요.")));
      return;
    }

    final result = await BusinessLoginStub().loginUser(
      businessNumber,
      password,
    );

    if (!mounted) return;

    if (result["success"] == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BusinessHome(
            userId: result["userId"].toString(),
            name: result["name"],
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result["message"] ?? "로그인 실패")));
    }
  }

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
            const PageTitle("사업체 로그인"), // 🔥 변경된 부분
            const SizedBox(height: 20),

            AppTextField(label: '사업자 번호', controller: businessNumberController),
            const SizedBox(height: 12),

            AppTextField(
              label: '비밀번호',
              obscure: true,
              controller: passwordController,
            ),
            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _login,
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

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('비밀번호 재설정', style: TextStyle(color: Colors.grey)),
                const SizedBox(width: 12),
                const Text('|', style: TextStyle(color: Colors.grey)),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BusinessSignup(),
                      ),
                    );
                  },
                  child: const Text(
                    '사업체 아이디 등록',
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
