import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminBusinessRequestScreen extends StatefulWidget {
  const AdminBusinessRequestScreen({super.key});

  @override
  State<AdminBusinessRequestScreen> createState() =>
      _AdminBusinessRequestScreenState();
}

class _AdminBusinessRequestScreenState
    extends State<AdminBusinessRequestScreen> {
  List<dynamic> requestList = [];

  @override
  void initState() {
    super.initState();
    loadBusinessRequests();
  }

  Future<void> loadBusinessRequests() async {
    try {
      final jsonString = await rootBundle
          .loadString("lib/assets/data/business_registration_list.json");
      final data = json.decode(jsonString);

      setState(() {
        requestList = data;
      });
    } catch (e) {
      print("로딩 실패: $e");
    }
  }

  void showRequestDetail(dynamic item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item["business_name"],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text("카테고리: ${item['business_category']}"),
            Text("영업시간: ${item['business_hours']}"),
            Text("사업자 번호: ${item['business_id']}"),
            Text("위도: ${item['business_lat']}"),
            Text("경도: ${item['business_lng']}"),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("승인 처리되었습니다.")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 50),
                    ),
                    child: const Text("승인"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("거절 처리되었습니다.")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 50),
                    ),
                    child: const Text("거절"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildRequestCard(dynamic item) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: () => showRequestDetail(item),
        title: Text(
          item["business_name"],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle:
            Text("${item['business_category']} · 영업시간 ${item['business_hours']}"),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("사업체 등록 신청 관리")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: requestList.isEmpty
            ? const Center(child: Text("등록 신청이 없습니다."))
            : ListView.builder(
                itemCount: requestList.length,
                itemBuilder: (context, index) {
                  return buildRequestCard(requestList[index]);
                },
              ),
      ),
    );
  }
}
