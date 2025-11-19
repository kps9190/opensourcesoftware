import 'package:flutter/material.dart';
import 'widgets/card_container.dart';
import 'widgets/menu_item_card.dart';

class BusinessMenu extends StatelessWidget {
  const BusinessMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('메뉴 관리'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CardContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '새 메뉴 추가',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 150,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: const InputDecoration(labelText: '메뉴 이름'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: const InputDecoration(labelText: '메뉴 설명'),
                  ),
                  const SizedBox(height: 8),
                  TextField(decoration: const InputDecoration(labelText: '가격')),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('메뉴 추가'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CardContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '등록된 메뉴',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  MenuItemCard(
                    imagePath: 'assets/images/bagel.jpg',
                    title: '금오 베이글 - 5,000원',
                    subtitle: '따뜻하고 맛있는 베이글',
                    onEdit: () {},
                    onDelete: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
