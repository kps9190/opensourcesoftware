import 'package:flutter/material.dart';

class CategoryFilterBar extends StatelessWidget {
  final Set<String> selected;
  final Function(String) onTap;
  final bool multiLine;  // ← 추가!

  static const List<Map<String, dynamic>> filters = [
    {'label': '한식', 'icon': Icons.rice_bowl},
    {'label': '양식', 'icon': Icons.restaurant},
    {'label': '일식', 'icon': Icons.set_meal},
    {'label': '중식', 'icon': Icons.ramen_dining},
    {'label': '카페', 'icon': Icons.local_cafe},
    {'label': '해산물', 'icon': Icons.lunch_dining},
    {'label': '뷔페', 'icon': Icons.food_bank},
    {'label': '아시아식', 'icon': Icons.dinner_dining},
  ];

  const CategoryFilterBar({
    super.key,
    required this.selected,
    required this.onTap,
    this.multiLine = false,
  });

  @override
  Widget build(BuildContext context) {
    final children = filters.map((cat) {
      final isSelected = selected.contains(cat['label']);

      return Padding(
        padding: const EdgeInsets.only(right: 8, bottom: 8),
        child: Material(
          color: isSelected ? Colors.orange : Colors.white,
          borderRadius: BorderRadius.circular(12),
          elevation: 1.5,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => onTap(cat['label']),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(cat['icon'],
                      size: 18,
                      color: isSelected ? Colors.white : Colors.orange),
                  const SizedBox(width: 6),
                  Text(
                    cat['label'],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();

    // ✔ 여러 줄 → Wrap
    if (multiLine) {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: children,
      );
    }

    // ✔ 한 줄 스크롤 → Row + SingleChildScrollView
    return SizedBox(
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: children),
      ),
    );
  }
}
