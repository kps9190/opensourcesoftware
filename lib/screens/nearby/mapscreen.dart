// lib/nearby/mapscreen.dart
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const markerLocation = NLatLng(37.5666, 126.979);
    final safeAreaPadding = MediaQuery.paddingOf(context);

    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Positioned.fill(
            child: NaverMap(
              options: NaverMapViewOptions(
                contentPadding: safeAreaPadding,
                initialCameraPosition: NCameraPosition(
                  target: markerLocation,
                  zoom: 14,
                ),
              ),
              onMapReady: (controller) {
                controller.addOverlay(
                  NMarker(
                    id: "markerLocation",
                    position: markerLocation,
                  ),
                );
              },
            ),
          ),

          // 검색창
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Container(
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
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.place), label: '내 주변'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '내 정보'),
        ],
      ),
    );
  }
}
