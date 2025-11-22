import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widget/naver_map.dart';
import '../widget/bottom_nav_bar_widget.dart';

class NearMyLocMapPage extends StatefulWidget {
  const NearMyLocMapPage({super.key});

  @override
  State<NearMyLocMapPage> createState() => _NearMyLocMapPageState();
}

class _NearMyLocMapPageState extends State<NearMyLocMapPage> {
  final Set<String> _selectedCategories = {};
  List<dynamic> businessList = [];

  @override
  void initState() {
    super.initState();
    _loadBusinessData();
  }

  Future<void> _loadBusinessData() async {
    final jsonString = await rootBundle.loadString('lib/data/business_data.json');
    final data = json.decode(jsonString);
    setState(() {
      businessList = data;
    });
  }

  void _toggleCategory(String label) {
    setState(() {
      if (_selectedCategories.contains(label)) {
        _selectedCategories.remove(label);
      } else {
        _selectedCategories.add(label);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final markers = businessList.map((b) {
      return {
        "id": b["business_id"].toString(),
        "lat": b["business_lat"],
        "lng": b["business_lng"],
      };
    }).toList();

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: NaverMapView(
              markers: markers,
            ),
          ),

          const Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: MapScreenSearchBar(),
          ),

          Positioned(
            top: 105,
            left: 0,
            right: 0,
            child: MapScreenCategoryBar(
              selected: _selectedCategories,
              onTap: _toggleCategory,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}

// 카테고리 바
class MapScreenCategoryBar extends StatelessWidget {
  final Set<String> selected;
  final Function(String) onTap;

  const MapScreenCategoryBar({
    super.key,
    required this.selected,
    required this.onTap,
  });

  static const List<Map<String, dynamic>> filters = [
    {'label': '한식', 'icon': Icons.rice_bowl},
    {'label': '일식', 'icon': Icons.set_meal},
    {'label': '중식', 'icon': Icons.ramen_dining},
    {'label': '양식', 'icon': Icons.restaurant},
    {'label': '아시아식', 'icon': Icons.dinner_dining},
    {'label': '해산물', 'icon': Icons.lunch_dining},
    {'label': '육류', 'icon': Icons.outdoor_grill},
    {'label': '파인다이닝', 'icon': Icons.wine_bar},
    {'label': '카페', 'icon': Icons.local_cafe},
    {'label': '베이커리', 'icon': Icons.cake},
    {'label': '펍/바', 'icon': Icons.local_bar},
    {'label': '뷔페', 'icon': Icons.food_bank},
  ];

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
                  Icon(
                    cat['icon'],
                    size: 18,
                    color: isSelected ? Colors.white : Colors.orange,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    cat['label'],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();

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

//검색바
class MapScreenSearchBar extends StatelessWidget {
  const MapScreenSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: '매장, 지역으로 검색 해 보세요',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
