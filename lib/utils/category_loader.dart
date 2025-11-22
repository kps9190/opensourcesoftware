import 'dart:convert';
import 'package:flutter/services.dart';

class CategoryLoader {
  static Future<List<String>> load() async {
    final jsonStr =
    await rootBundle.loadString('assets/data/category_list.json');
    final List list = jsonDecode(jsonStr);
    return list.map((e) => e.toString()).toList();
  }
}
