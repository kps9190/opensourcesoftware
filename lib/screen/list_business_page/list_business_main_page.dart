import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/category_loader.dart';
import '../widget/bottom_nav_bar_widget.dart';

class ListBusinessMainPage extends StatefulWidget {
  const ListBusinessMainPage({super.key});

  @override
  State<ListBusinessMainPage> createState() => _ListBusinessMainPageState();
}

class _ListBusinessMainPageState extends State<ListBusinessMainPage>
    with TickerProviderStateMixin {
  late TabController _tab;

  final List<String> priceTabs = [
    '전체',
    '3만원 이하',
    '3-5만원',
    '5-10만원',
    '10만원 이상',
  ];

  final Set<String> _selectedCategories = {};

  List<dynamic> all = [];
  List<String> categories = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();

    _tab = TabController(length: priceTabs.length, vsync: this)
      ..addListener(() => setState(() {}));

    _load();
  }

  Future<void> _load() async {
    final businessJson =
    await rootBundle.loadString('assets/jsons/business_data.json');
    all = json.decode(businessJson);

    categories = await CategoryLoader.load();

    setState(() => loading = false);
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

  List<dynamic> get filtered {
    if (loading) return [];

    return all.where((r) {
      final cat = r["business_category"];
      return _selectedCategories.isEmpty || _selectedCategories.contains(cat);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: priceTabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text(
            "카테고리 / 가격대 검색",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        body: loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- 카테고리 선택 ----
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: CategorySelector(
                categories: categories,
                selected: _selectedCategories,
                onTap: _toggleCategory,
              ),
            ),

            // ---- 가격대 탭 ----
            TabBar(
              controller: _tab,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.deepOrange,
              isScrollable: true,
              tabs: priceTabs.map((t) => Tab(text: t)).toList(),
            ),

            const SizedBox(height: 10),

            // ---- 필터된 비즈니스 리스트 ----
            Expanded(
              child: ListView(
                children: filtered.map((b) {
                  return ListTile(
                    title: Text(b["business_name"]),
                    subtitle: Text(b["business_category"]),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      ),
    );
  }
}

class CategorySelector extends StatelessWidget {
  final List<String> categories;
  final Set<String> selected;
  final Function(String) onTap;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((c) {
        final isSelected = selected.contains(c);

        return GestureDetector(
          onTap: () => onTap(c),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isSelected ? Colors.orange : Colors.white,
              border: Border.all(
                color: isSelected ? Colors.orange : Colors.grey.shade400,
              ),
            ),
            child: Text(
              c,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

