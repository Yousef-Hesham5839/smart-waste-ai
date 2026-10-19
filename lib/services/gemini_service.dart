import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/waste_classification.dart';

class GeminiClassifierService {
  static const String _apiKeyPrefKey = 'gemini_custom_api_key';
  
  // Default fallback API key if user has not entered a custom one
  // Users can easily update or add their own key in the Settings screen!
  static const String defaultKey = '';

  static Future<String?> getApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    final customKey = prefs.getString(_apiKeyPrefKey);
    if (customKey != null && customKey.trim().isNotEmpty) {
      return customKey.trim();
    }
    return defaultKey.isNotEmpty ? defaultKey : null;
  }

  static Future<void> setApiKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_apiKeyPrefKey, key.trim());
  }

  static Future<WasteClassificationResult?> classifyWasteWithGemini(
    String imagePath,
  ) async {
    final apiKey = await getApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      return null;
    }

    try {
      final file = File(imagePath);
      if (!await file.exists()) return null;
      final bytes = await file.readAsBytes();

      // Use gemini-1.5-flash or gemini-2.0-flash for fast and accurate multimodal image recognition
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
          temperature: 0.2,
        ),
      );

      const prompt = '''
You are an expert Decision Support System (DSS) and AI Computer Vision classifier for smart waste management and recycling.
Analyze the provided image of an object to be discarded into a trash bin.
Your task is to classify this waste item strictly into ONE of these 4 primary material categories:
1. "metal" (e.g. aluminum cans, tin cans, metal caps, foil, cutlery, wire, scrap)
2. "paper" (e.g. cardboard boxes, newspapers, magazines, office paper, clean paper packaging)
3. "glass" (e.g. glass bottles, glass jars, glassware)
4. "plastic" (e.g. plastic water/soda bottles, plastic containers, bags, cups, wrap, plastic packaging)

If the object contains multiple materials (e.g. paper box with plastic tape, or glass bottle with metal cap), classify it by its MAIN recyclable component.

Output valid JSON only with this schema:
{
  "category": "metal" | "paper" | "glass" | "plastic",
  "itemNameArabic": "string name in Arabic (e.g. علبة كانز ألومنيوم)",
  "itemNameEnglish": "string name in English (e.g. Aluminum Soda Can)",
  "confidence": float between 0.70 and 0.99,
  "explanationArabic": "Concise Arabic explanation of why it was classified into this category based on visual features (color, texture, shape, luster)",
  "isRecyclable": true | false,
  "probabilities": {
    "metal": float 0.0 to 1.0,
    "paper": float 0.0 to 1.0,
    "glass": float 0.0 to 1.0,
    "plastic": float 0.0 to 1.0
  },
  "decisionRecommendation": "Detailed DSS recommendation in Arabic on how to prepare the item (rinsing, flattening) and which bin color to use."
}
Make sure the sum of probabilities is 1.0.
''';

      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart('image/jpeg', bytes),
        ])
      ];

      final response = await model.generateContent(content);
      final text = response.text;
      if (text == null || text.isEmpty) return null;

      final Map<String, dynamic> data = jsonDecode(text);

      final catStr = (data['category'] as String?)?.toLowerCase() ?? 'plastic';
      final category = WasteCategory.fromString(catStr);
      final confidence = (data['confidence'] as num?)?.toDouble() ?? 0.92;
      final itemNameAr = data['itemNameArabic'] as String? ?? category.arabicName;
      final explanation = data['explanationArabic'] as String? ?? 'تم تصنيف العنصر بنجاح عبر نموذج الذكاء الاصطناعي.';
      final isRecyclable = data['isRecyclable'] as bool? ?? true;
      final decisionRec = data['decisionRecommendation'] as String? ?? category.binDescription;

      final rawProb = data['probabilities'] as Map<String, dynamic>? ?? {};
      final Map<WasteCategory, double> probs = {
        WasteCategory.metal: (rawProb['metal'] as num?)?.toDouble() ?? (category == WasteCategory.metal ? confidence : 0.05),
        WasteCategory.paper: (rawProb['paper'] as num?)?.toDouble() ?? (category == WasteCategory.paper ? confidence : 0.05),
        WasteCategory.glass: (rawProb['glass'] as num?)?.toDouble() ?? (category == WasteCategory.glass ? confidence : 0.05),
        WasteCategory.plastic: (rawProb['plastic'] as num?)?.toDouble() ?? (category == WasteCategory.plastic ? confidence : 0.05),
      };

      // Normalize probabilities
      final sum = probs.values.reduce((a, b) => a + b);
      if (sum > 0) {
        probs.updateAll((key, value) => double.parse((value / sum).toStringAsFixed(3)));
      }

      return WasteClassificationResult(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imagePath: imagePath,
        category: category,
        confidence: confidence,
        itemName: itemNameAr,
        explanation: explanation,
        probabilities: probs,
        timestamp: DateTime.now(),
        isRecyclable: isRecyclable,
        decisionRecommendation: decisionRec,
      );
    } catch (e) {
      // In case of API failure, timeout, or quota, log error and return null to fallback
      debugPrint('Gemini classification error: $e');
      return null;
    }
  }
}
