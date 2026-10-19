import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/waste_classification.dart';

class HistoryService {
  static const String _storageKey = 'waste_history_records';

  static Future<List<WasteClassificationResult>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_storageKey) ?? [];
    return jsonList.map((str) {
      try {
        final map = jsonDecode(str) as Map<String, dynamic>;
        return WasteClassificationResult.fromJson(map);
      } catch (e) {
        return null;
      }
    }).whereType<WasteClassificationResult>().toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  static Future<void> saveResult(WasteClassificationResult result) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_storageKey) ?? [];
    jsonList.insert(0, jsonEncode(result.toJson()));
    // Keep last 100 scans to avoid excessive storage
    if (jsonList.length > 100) {
      jsonList.removeRange(100, jsonList.length);
    }
    await prefs.setStringList(_storageKey, jsonList);
  }

  static Future<void> deleteItem(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_storageKey) ?? [];
    jsonList.removeWhere((str) {
      try {
        final map = jsonDecode(str) as Map<String, dynamic>;
        return map['id'] == id;
      } catch (_) {
        return false;
      }
    });
    await prefs.setStringList(_storageKey, jsonList);
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }

  static Future<Map<WasteCategory, int>> getCategoryCounts() async {
    final history = await getHistory();
    final counts = {
      WasteCategory.metal: 0,
      WasteCategory.paper: 0,
      WasteCategory.glass: 0,
      WasteCategory.plastic: 0,
    };
    for (var item in history) {
      counts[item.category] = (counts[item.category] ?? 0) + 1;
    }
    return counts;
  }
}
