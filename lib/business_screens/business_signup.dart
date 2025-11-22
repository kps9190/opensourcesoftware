import 'package:flutter/material.dart';
import '../users_screens/widgets/app_text_field.dart';
import './business_server_stub/business_login_stub.dart';
import '../users_screens/widgets/page_title.dart'; // 🔥 PageTitle import

class BusinessSignup extends StatefulWidget {
  const BusinessSignup({super.key});

  @override
  State<BusinessSignup> createState() => _BusinessSignupState();
}

class _BusinessSignupState extends State<BusinessSignup> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final businessNumberController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    businessNumberController.dispose();
    addressController.dispose();
    passwordController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final businessNumber = businessNumberController.text.trim();
    final address = addressController.text.trim();
    final password = passwordController.text.trim();
    final description = descriptionController.text.trim();

    if ([
      name,
      phone,
      email,
      businessNumber,
      address,
      password,
      description,
    ].any((element) => element.isEmpty)) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('모든 항목을 입력해주세요.')));
      return;
    }

    final result = await BusinessLoginStub().registerUser(
      name,
      phone,
      email,
      businessNumber,
      address,
      password,
      description,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(result['message'] ?? '등록 실패')));

    if (result['success'] == true) {
      Navigator.pop(context);
    }
  }

  Future<void> _sendVerifyCode() async {
    final phone = phoneController.text.trim();
    if (phone.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('전화번호를 입력해주세요.')));
      return;
    }

    final result = await BusinessLoginStub().sendVerifyCode(phone);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result['success'] == true ? '인증번호: ${result['code']}' : '인증 실패',
        ),
      ),
    );
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageTitle("사업체 등록"), // 🔥 변경된 부분
              const SizedBox(height: 13),

              AppTextField(label: '이름', controller: nameController),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      label: '전화번호',
                      controller: phoneController,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _sendVerifyCode,
                    child: const Text('인증'),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              AppTextField(label: '이메일', controller: emailController),
              const SizedBox(height: 12),

              AppTextField(
                label: '사업자 번호',
                controller: businessNumberController,
              ),
              const SizedBox(height: 12),

              AppTextField(label: '주소', controller: addressController),
              const SizedBox(height: 12),

              AppTextField(
                label: '비밀번호',
                obscure: true,
                controller: passwordController,
              ),
              const SizedBox(height: 12),

              AppTextField(
                label: '사업체 간략 소개',
                controller: descriptionController,
              ),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _register,
                    child: const Text('등록 요청하기'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
