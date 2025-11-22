import 'package:flutter/material.dart';
import 'login.dart';
import '../business_screens/business_login.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _LoginButton(
              color: Colors.blue[50]!,
              borderColor: Colors.blueAccent,
              icon: Icons.person,
              label: '사용자 로그인',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
            const SizedBox(width: 40),
            _LoginButton(
              color: Colors.orange[50]!,
              borderColor: Colors.orangeAccent,
              icon: Icons.store,
              label: '사업체 로그인',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BusinessLogin(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// MyHomePage 안에서만 사용되는 private 위젯
class _LoginButton extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _LoginButton({
    required this.color,
    required this.borderColor,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 2),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: borderColor),
              const SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: borderColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
