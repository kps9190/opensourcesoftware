import 'package:flutter/material.dart';
import '../screen/sysadmin_page/sysadmin_business_management_page.dart';
import '../screen/sysadmin_page/sysadmin_business_request_page.dart';
import '../screen/sysadmin_page/sysadmin_customer_management_page.dart';
import '../screen/sysadmin_page/sysadmin_voc_management_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Developer Mode Demo',
      debugShowCheckedModeBanner: false,
      home: const DeveloperMode(),
    );
  }
}

class DeveloperMode extends StatelessWidget {
  const DeveloperMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('개발자 모드')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 20),

          _devButton(
            context,
            title: 'sysadmin_business_registration',
            page: const AdminBusinessManageScreen(),
          ),
          _devButton(
            context,
            title: 'sysadmin_business_request',
            page: const AdminBusinessRequestScreen(),
          ),
          _devButton(
            context,
            title: 'sysadmin_customer_management',
            page: const AdminCustomerScreen(),
          ),
          _devButton(
            context,
            title: 'sysadmin_voc_management',
            page: const AdminVocScreen(),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _devButton(BuildContext context,
      {required String title, required Widget page}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        onPressed: () => _go(context, page),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(title, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  void _go(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }
}