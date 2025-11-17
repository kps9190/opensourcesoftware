import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminCustomerScreen extends StatefulWidget {
  @override
  State<AdminCustomerScreen> createState() => _AdminCustomerScreenState();
}

class _AdminCustomerScreenState extends State<AdminCustomerScreen> {
  List<dynamic> allUsers = [];
  List<dynamic> customerList = [];

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final jsonString =
        await rootBundle.loadString("lib/data/user_data.json");
    final data = json.decode(jsonString);

    setState(() {
      allUsers = data;
      customerList = data.where(
        (user) =>
            user["role_admin"] == false &&
            user["role_business"] == false,
      ).toList();
    });
  }

  void showCustomerDetail(dynamic user) {
    showModalBottomSheet(
      context: context,
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
              "${user["nickname"]} 님",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            Text("User ID: ${user["user_id"]}"),
            Text("Email: ${user["email"]}"),
            const SizedBox(height: 10),
            Text("role_admin: ${user["role_admin"]}"),
            Text("role_business: ${user["role_business"]}"),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("삭제 기능은 준비 중입니다."),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text("사용자 삭제"),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCustomerCard(dynamic user) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: () => showCustomerDetail(user),
        title: Text(
          user["nickname"],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(user["email"]),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("고객 관리"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: customerList.isEmpty
            ? const Center(child: Text("등록된 고객이 없습니다."))
            : ListView.builder(
                itemCount: customerList.length,
                itemBuilder: (context, index) {
                  return buildCustomerCard(customerList[index]);
                },
              ),
      ),
    );
  }
}
