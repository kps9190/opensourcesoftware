import 'dart:convert';
import 'package:flutter/services.dart';

class UserRepository {
  static List<dynamic> _users = [];

  static Future<void> load() async {
    final jsonString = await rootBundle.loadString("lib/data/user_data.json");
    _users = json.decode(jsonString);
  }

  static List<dynamic> get users => _users;

  static Map<String, dynamic>? findById(int id) {
    try {
      return _users.firstWhere((u) => u["user_id"] == id);
    } catch (_) {
      return null;
    }
  }

  static Map<String, dynamic>? findByEmail(String email) {
    try {
      return _users.firstWhere((u) => u["email"] == email);
    } catch (_) {
      return null;
    }
  }
}
