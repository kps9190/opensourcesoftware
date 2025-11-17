import 'package:flutter/material.dart';
import '../models/business_model.dart';

class BusinessList extends StatelessWidget {
  final List<Business> businesses;

  const BusinessList({super.key, required this.businesses});

  @override
  Widget build(BuildContext context) {
    if (businesses.isEmpty) {
      return const Center(
        child: Text("조건에 맞는 식당이 없습니다."),
      );
    }

    return ListView.builder(
      itemCount: businesses.length,
      itemBuilder: (context, i) {
        final r = businesses[i];

        return ListTile(
          leading: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.restaurant, color: Colors.deepOrange),
          ),
          title: Text(r.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("${r.category} "),
        );
      },
    );
  }
}
