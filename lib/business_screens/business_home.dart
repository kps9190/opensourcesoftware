import 'package:flutter/material.dart';
import 'package:flutter_fb/business_screens/business_menu.dart';
import 'business_edit.dart';

class BusinessHome extends StatelessWidget {
  final String userId;
  final String name;

  const BusinessHome({super.key, required this.userId, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '$name님 홈 화면',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _simpleListTile('사업체 정보 수정', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BusinessEdit(),
                        ),
                      );
                    }),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(height: 1),
                    ),
                    _simpleListTile('대기/예약 관리', () {}),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(height: 1),
                    ),
                    _simpleListTile('메뉴 관리', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BusinessMenu(),
                        ),
                      );
                    }),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(height: 1),
                    ),
                    _simpleListTile('고객 리뷰 관리', () {}),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.hourglass_empty, size: 24),
                        SizedBox(width: 8),
                        Text(
                          '대기열 현황',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: _queueBox('접수중', Colors.green, '홀', '??팀'),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _queueBox('접수중', Colors.green, '테라스', '??팀'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: _queueBox('마감됨', Colors.red, '포장', '0팀'),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _queueBox('접수중', Colors.green, '테라스', '??팀'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _simpleListTile(String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: Text(title),
      onTap: onTap,
    );
  }

  static Widget _queueBox(
    String status,
    Color statusColor,
    String label,
    String count,
  ) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status,
              style: TextStyle(fontSize: 12, color: statusColor),
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(count, style: const TextStyle(fontSize: 25)),
        ],
      ),
    );
  }
}
