import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/business_model.dart';

class BusinessRepository {
  static Future<List<Business>> load() async {
    final jsonString = await rootBundle.loadString('lib/data/business_data.json');
    final List list = json.decode(jsonString);

    return list.map((e) => Business.fromJson(e)).toList();
  }
}
