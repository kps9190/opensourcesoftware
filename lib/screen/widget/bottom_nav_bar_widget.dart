import 'package:flutter/material.dart';
import '../list_business_page/list_business_main_page.dart';
import '../near_my_loc_page/near_my_loc_map_page.dart';
import '../customer_page/customer_information_page.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({
    super.key,
    required this.currentIndex,
  });
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == currentIndex) return;
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ListBusinessMainPage()),
            );
            break;

          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const NearMyLocMapPage()),
            );
            break;

          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const CustomerMyPageScreen()),
            );
            break;
        }

      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.place), label: '내 주변'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '내 정보'),
      ],
    );
  }
}