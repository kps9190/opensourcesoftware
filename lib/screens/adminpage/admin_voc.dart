import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class AdminVocScreen extends StatefulWidget {
  @override
  State<AdminVocScreen> createState() => _AdminVocScreenState();
}

class _AdminVocScreenState extends State<AdminVocScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic> vocList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    loadVocData();
  }

  Future<void> loadVocData() async {
    final jsonString = await rootBundle.loadString("lib/data/voc_data.json");
    final data = json.decode(jsonString);
    setState(() {
      vocList = data;
    });
  }

  List<dynamic> filterBySender(String type) {
    if (type == "all") return vocList;
    return vocList.where((v) => v["sender_type"] == type).toList();
  }

  void showVocDetail(dynamic voc) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목
            Text(
              voc["title"],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // 내용
            Text(
              voc["content"],
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            Text("작성자: ${voc["nickname"]}"),
            Text("구분: ${voc["sender_type"] == "customer" ? "고객" : "사업주"}"),
            Text("카테고리: ${voc["category"]}"),
            Text("작성일: ${voc["created_at"]}"),
            Text("처리일: ${voc["handled_at"] ?? "-"}"),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  voc["status"] = "resolved";
                  voc["handled_at"] =
                      DateTime.now().toString().substring(0, 16);
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text("처리 완료로 변경"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVocCard(dynamic voc) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        onTap: () => showVocDetail(voc),
        title: Text(
          voc["title"],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              voc["content"],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text("작성자: ${voc["nickname"]}"),
            Text("작성일: ${voc["created_at"]}")
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: voc["status"] == "pending" ? Colors.orange : Colors.green,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            voc["status"] == "pending" ? "대기" : "완료",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget buildVocList(List<dynamic> list) {
    if (list.isEmpty) {
      return const Center(
        child: Text("VOC가 없습니다."),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return buildVocCard(list[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VOC 관리"),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: "전체"),
            Tab(text: "고객"),
            Tab(text: "사업주"),
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          buildVocList(filterBySender("all")),
          buildVocList(filterBySender("customer")),
          buildVocList(filterBySender("owner")),
        ],
      ),
    );
  }
}
