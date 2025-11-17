import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widget/naver_map.dart';
import '../../widget/search_bar.dart';
import '../../widget/category_filter.dart';
import '../../widget/bottom_nav_bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Set<String> _selectedCategories = {};
  List<dynamic> businessList = [];

  @override
  void initState() {
    super.initState();
    _loadBusinessData();
  }

  Future<void> _loadBusinessData() async {
    final jsonString =
        await rootBundle.loadString('lib/data/business_data.json');
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
            child: CustomSearchBar(),
          ),

          Positioned(
            top: 105,
            left: 0,
            right: 0,
            child: CategoryFilterBar(
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
