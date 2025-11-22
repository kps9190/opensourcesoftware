import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class NaverMapView extends StatelessWidget {
  final Function(NaverMapController)? onMapReady;
  final List<dynamic> markers;

  final double initialLat;
  final double initialLng;
  final double initialZoom;


  const NaverMapView({
    super.key,
    this.onMapReady,
    this.markers = const [],
    this.initialLat = 37.5666,
    this.initialLng = 126.9790,
    this.initialZoom = 13,
  });

  @override
  Widget build(BuildContext context) {
    return NaverMap(
      options: NaverMapViewOptions(
        initialCameraPosition: NCameraPosition(
          target: NLatLng(initialLat, initialLng),
          zoom: initialZoom,
        ),
      ),

      onMapReady: (controller) async {
        for (var m in markers) {
          controller.addOverlay(
            NMarker(
              id: m["id"].toString(),
              position: NLatLng(m["lat"], m["lng"]),
            ),
          );
        }

        if (onMapReady != null) {
          onMapReady!(controller);
        }
      },
    );
  }
}
