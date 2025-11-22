import 'package:flutter/material.dart';
import 'internal_login_page.dart';

class LoginOptionPage extends StatelessWidget {
  const LoginOptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.black),
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _LoginLogo(),
          const _LoginButtons(),
          _EmailLoginLink(),
        ],
      ),
    );
  }
}


class _LoginLogo extends StatelessWidget {
  const _LoginLogo();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/login_symbol_big.png',
              width: 120,
              height: 120,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginButtons extends StatelessWidget {
  const _LoginButtons();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: const [
          LoginButton(
            color: Color(0xFF03C75A),
            textColor: Colors.white,
            icon: Icons.nature,
            text: '네이버로 계속하기',
          ),
          SizedBox(height: 10),
          LoginButton(
            color: Color(0xFFFEE500),
            textColor: Colors.black,
            icon: Icons.chat_bubble,
            text: '카카오톡으로 계속하기',
          ),
          SizedBox(height: 10),
          LoginButton(
            color: Colors.black,
            textColor: Colors.white,
            icon: Icons.apple,
            text: 'Apple로 계속하기',
          ),
        ],
      ),
    );
  }
}


class LoginButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const LoginButton({
    super.key,
    required this.color,
    required this.textColor,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor),
            const SizedBox(width: 8),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailLoginLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.grey, fontSize: 14),
          children: [
            const TextSpan(text: '이메일로 가입하셨나요?  '),
            WidgetSpan(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const InternalLoginScreen(),
                    ),
                  );
                },
                child: const Text(
                  '로그인하기',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
