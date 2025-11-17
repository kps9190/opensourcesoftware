import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../reservation/waiting_popup.dart';


class BusinessInfoPage extends StatefulWidget {
  final Map<String, dynamic> business;

  const BusinessInfoPage({super.key, required this.business});

  @override
  State<BusinessInfoPage> createState() => _BusinessInfoPageState();
}

class _BusinessInfoPageState extends State<BusinessInfoPage> {
  List<dynamic> menuList = [];

  @override
  void initState() {
    super.initState();
    _loadMenu();
  }

  Future<void> _loadMenu() async {
    final jsonString = await rootBundle.loadString("lib/data/menu_data.json");
    final data = json.decode(jsonString);

    setState(() {
      menuList = data
          .where((m) => m["business_id"] == widget.business["business_id"])
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final business = widget.business;

    return Scaffold(
      appBar: AppBar(
        title: Text(business["business_name"]),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------------------
            // 가게 이미지
            // ------------------------------
            Image.asset(
              "assets/images/store_image.jpg",
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ------------------------------
                  // 가게 이름
                  // ------------------------------
                  Text(
                    business["business_name"],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    business["business_description"] ?? "",
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 16),

                  // ------------------------------
                  // 주소
                  // ------------------------------
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 18),
                      const SizedBox(width: 6),
                      Expanded(child: Text(business["business_address"])),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 18),
                      const SizedBox(width: 6),
                      Text("영업시간 ${business["business_hours"]}"),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Divider(),

                  // ------------------------------
                  // 메뉴 리스트
                  // ------------------------------
                  const Text(
                    "메뉴",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  menuList.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text("메뉴 정보가 없습니다."),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: menuList.length,
                          itemBuilder: (_, i) {
                            final item = menuList[i];
                            return ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 8),
                              title: Text(
                                item["menu_name"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(item["menu_desc"]),
                              trailing: Text(
                                "${item["menu_price"]}원",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      // ------------------------------
      // 하단 예약 버튼
      // ------------------------------
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {
            showWaitingTypeSelectionSheet(context); // ← 예약 팝업 호출
          },
          child: const Text("예약하기"),
        ),
      ),
    );
  }
}
