import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminBusinessManageScreen extends StatefulWidget {
  @override
  State<AdminBusinessManageScreen> createState() =>
      _AdminBusinessManageScreenState();
}

class _AdminBusinessManageScreenState
    extends State<AdminBusinessManageScreen> {
  List<dynamic> businessList = [];

  @override
  void initState() {
    super.initState();
    loadBusinessData();
  }

  Future<void> loadBusinessData() async {
    final jsonString =
        await rootBundle.loadString("lib/data/business_data.json");
    final data = json.decode(jsonString);

    setState(() {
      businessList = data;
    });
  }

  void showBusinessDetail(dynamic item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
            Text("설명: ${item['business_description']}"),
            Text("주소: ${item['business_address']}"),
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
                        const SnackBar(content: Text("수정 기능 (준비 중)")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 50),
                    ),
                    child: const Text("수정"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("삭제 기능 (준비 중)")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 50),
                    ),
                    child: const Text("삭제"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBusinessCard(dynamic item) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: () => showBusinessDetail(item),
        title: Text(
          item["business_name"],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "${item['business_category']} · ${item['business_address']}",
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("사업장 관리"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: businessList.isEmpty
            ? const Center(child: Text("등록된 사업장이 없습니다."))
            : ListView.builder(
                itemCount: businessList.length,
                itemBuilder: (context, index) {
                  return buildBusinessCard(businessList[index]);
                },
              ),
      ),
    );
  }
}
