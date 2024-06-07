import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/**
 * Classe para tratar questão do cache do aplicativo
 */
class CacheManager {
  Future<void> cacheWordData(String word, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(word, jsonEncode(data));
  }

  Future<Map<String, dynamic>?> getCachedWordData(String word) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(word);
    if (jsonData != null) {
      return jsonDecode(jsonData);
    }
    return null;
  }
}
