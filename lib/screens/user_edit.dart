import 'package:flutter/material.dart';
import 'user_delete.dart';

class UserEditScreen extends StatefulWidget {
  const UserEditScreen({super.key});

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final server = Server(); 

  late TextEditingController _nicknameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final user = server.getUserInfo();

    _nicknameController = TextEditingController(text: user['nickname']);
    _emailController = TextEditingController(text: user['email']);
    _phoneController = TextEditingController(text: user['phone']);
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _saveUserInfo() {
    server.updateUserInfo({
      'nickname': _nicknameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('정보가 저장되었습니다 :)')),
    );
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

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: _saveUserInfo,    
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
                      builder: (_) => UserDeleteScreen(server: server),
                    ),
                  );
                },
                child: const Text('회원탈퇴'),
              ),
              TextButton(
                onPressed: () {
                  // 로그아웃 (추후 연결)
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

//Stub Server (가상 서버)

class Server {
  Map<String, String> _user = {
    'nickname': 'DaHee',
    'email': 'dahee@example.com',
    'phone': '010-1234-5678',
  };

  Map<String, String> getUserInfo() {
    return Map.from(_user); 
  }

  void updateUserInfo(Map<String, String> newInfo) {
    _user = newInfo;
  }

  bool deleteUser() {
    _user = {};
    return true;
  }
}
