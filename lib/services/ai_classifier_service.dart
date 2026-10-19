import 'package:flutter/foundation.dart';
import '../models/waste_classification.dart';
import 'gemini_service.dart';
import 'local_classifier_service.dart';
import 'history_service.dart';

class AIClassifierService {
  /// Classifies a waste image using Hybrid AI (Gemini Multimodal Vision + Local CV fallback)
  static Future<WasteClassificationResult> classifyImage(String imagePath) async {
    WasteClassificationResult? result;

    // 1. Try Gemini Vision if API key is provided
    try {
      result = await GeminiClassifierService.classifyWasteWithGemini(imagePath);
      if (result != null) {
        debugPrint('Classified using Gemini Vision AI: ${result.category.name}');
      }
    } catch (e) {
      debugPrint('Gemini classification exception: $e');
    }

    // 2. Fallback to Local Computer Vision & On-Device ML if Gemini is unavailable
    if (result == null) {
      debugPrint('Falling back to Local On-Device Classifier');
      result = await LocalClassifierService.classifyLocal(imagePath);
    }

    // 3. Persist the classification to history
    try {
      await HistoryService.saveResult(result);
    } catch (e) {
      debugPrint('Failed to save to history: $e');
    }

    return result;
  }
}
