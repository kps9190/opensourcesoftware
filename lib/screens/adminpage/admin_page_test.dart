import 'package:flutter/material.dart';

// 우리가 만든 관리자 페이지 4개 import
import './admin_voc.dart';
import './admin_business_registration.dart';
import './admin_business.dart';
import './admin_customer.dart';

class AdminPageTest extends StatelessWidget {
  const AdminPageTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Page Test"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "관리자 페이지 접근 테스트",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          // 1) VOC 페이지 이동
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AdminVocScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text("VOC 관리 페이지 이동"),
          ),

          const SizedBox(height: 12),

          // 2) 사업체 등록 신청 관리 이동
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AdminBusinessRequestScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text("사업체 등록 신청 관리 이동"),
          ),

          const SizedBox(height: 12),

          // 3) 사업장 관리 이동
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AdminBusinessManageScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text("사업장 관리 이동"),
          ),

          const SizedBox(height: 12),

          // 4) 고객 관리 이동
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AdminCustomerScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text("고객 관리 페이지 이동"),
          ),
        ],
      ),
    );
  }
}
