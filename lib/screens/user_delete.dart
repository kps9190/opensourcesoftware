import 'package:flutter/material.dart';
import 'user_edit.dart'; 

class UserDeleteScreen extends StatefulWidget {
  final Server server;

  const UserDeleteScreen({super.key, required this.server});

  @override
  State<UserDeleteScreen> createState() => _UserDeleteScreenState();
}

class _UserDeleteScreenState extends State<UserDeleteScreen> {
  bool _agreed = false;

  void _deleteUser() {
    widget.server.deleteUser();

    Navigator.pop(context); 

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('회원 탈퇴가 완료되었습니다.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '서비스 탈퇴 전 유의사항',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF1F1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red),
                      SizedBox(width: 6),
                      Text(
                        '꼭 읽어주세요',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '이용 예정 또는 이용 중인 예약, 원격줄서기, 주문 건이 있을 경우 탈퇴할 수 없습니다. '
                    '테이블링페이 머니 잔액이 있다면 전액 인출 후 탈퇴를 진행해 주세요.',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              '• 탈퇴 후 매장 이용 취소 등으로 환불 금액이 발생할 수 있으므로 '
              '테이블링페이 머니와 관련된 정보를 최대 30일간 보관 후 삭제합니다.\n\n'
              '• 서비스 탈퇴 시 회원 전용 서비스 이용이 불가하며 '
              '회원 데이터는 일괄 삭제 처리됩니다.\n\n'
              '• 탈퇴 완료 후 계정 정보는 삭제되며 복원이 불가능합니다.',
              style: TextStyle(fontSize: 14, height: 1.6),
            ),

            const Spacer(),

            Row(
              children: [
                Checkbox(
                  value: _agreed,
                  onChanged: (v) => setState(() => _agreed = v ?? false),
                ),
                const Expanded(
                  child: Text('위 사실을 확인했습니다.',
                      style: TextStyle(fontSize: 15)),
                ),
              ],
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _agreed
                    ? () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('정말 탈퇴하시겠습니까?'),
                            content: const Text('이 작업은 되돌릴 수 없습니다.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('취소'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  _deleteUser(); // 🔥 Stub delete
                                },
                                child: const Text('탈퇴'),
                              ),
                            ],
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: _agreed
                      ? Colors.orange
                      : Colors.orange.withOpacity(0.4),
                ),
                child: const Text(
                  '계정 영구삭제',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
