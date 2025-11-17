import 'package:flutter/material.dart';
import '../../models/business_model.dart';
import '../../repository/business_repository.dart';
import '../../widget/category_filter.dart';
import '../../widget/business_list.dart';
import '../../widget/bottom_nav_bar.dart';

class CategoryAndPriceScreen extends StatefulWidget {
  const CategoryAndPriceScreen({super.key});

  @override
  State<CategoryAndPriceScreen> createState() => _CategoryAndPriceScreenState();
}

class _CategoryAndPriceScreenState extends State<CategoryAndPriceScreen>
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

  List<Business> all = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();

    _tab = TabController(length: priceTabs.length, vsync: this)
      ..addListener(() => setState(() {}));

    _load();
  }

  Future<void> _load() async {
    all = await BusinessRepository.load();
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

  List<Business> get filtered {
    if (loading) return [];

    return all.where((r) {
      final catOk = _selectedCategories.isEmpty ||
          _selectedCategories.contains(r.category);

      return catOk;
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: CategoryFilterBar(
                      selected: _selectedCategories,
                      onTap: _toggleCategory,
                      multiLine: true,
                    ),
                  ),

                  TabBar(
                    controller: _tab,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.deepOrange,
                    isScrollable: true,
                    tabs: priceTabs.map((t) => Tab(text: t)).toList(),
                  ),

                  const SizedBox(height: 10),

                  Expanded(
                    child: BusinessList(businesses: filtered),
                  ),
                ],
              ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      ),
    );
  }
}
