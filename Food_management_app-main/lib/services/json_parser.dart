import 'dart:convert';
import 'package:flutter/services.dart';

class JsonParser {
  static Future<Map<String, dynamic>> loadMenu() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/restaurant_menu.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return jsonData['menu'];
    } catch (error) {
      print("Error loading JSON: $error");
      return {};
    }
  }
}
