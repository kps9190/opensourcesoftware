import 'package:flutter/material.dart';
import '../screens/adminpage/admin_page_test.dart';
import '../screens/search/map_screen.dart';
import '../screens/user/mypage.dart';
import '../screens/search/category_and_price.dart';

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

        Widget target;

        switch (index) {
          case 0:
            target = const CategoryAndPriceScreen();
            break;
          case 1:
            target = const MapScreen();
            break;
          case 2:
            target = const AdminPageTest();
            break;
          case 3:
            target = const MyPageScreen();
            break;
          default:
            return;
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => target),
        );
      },

      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.place), label: '내 주변'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: '관리자 페이지'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '내 정보'),
      ],
    );
  }
}
