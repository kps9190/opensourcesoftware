import 'package:flutter/material.dart';
import 'user_delete.dart';

class UserEditScreen extends StatefulWidget {
  const UserEditScreen({super.key});

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final _nicknameController = TextEditingController(text: 'DaHee');
  final _emailController = TextEditingController(text: 'dahee@example.com');
  final _phoneController = TextEditingController(text: '010-1234-5678');
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내정보 관리'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildEditableItem(
            title: '닉네임',
            controller: _nicknameController,
          ),
          _buildEditableItem(
            title: '이메일',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          _buildEditableItem(
            title: '휴대폰번호',
            controller: _phoneController,
            keyboardType: TextInputType.phone,
          ),
          _buildEditableItem(
            title: '비밀번호',
            controller: _passwordController,
            obscureText: true,
            hintText: '새로운 비밀번호로 변경 가능',
          ),

          const SizedBox(height: 30),

          // 저장 버튼
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('정보가 저장되었습니다 :)')),
              );
            },
            child: const Text('저장하기'),
          ),

          const SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const UserDeleteScreen(),
                    ),
                  );
                },
                child: const Text('회원탈퇴'),
              ),
              TextButton(
                onPressed: () {
                  // 로그아웃 기능 (추후 연결)
                },
                child: const Text('로그아웃'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditableItem({
    required String title,
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
