import 'package:flutter/material.dart';

enum WasteCategory {
  metal,
  paper,
  glass,
  plastic;

  String get arabicName {
    switch (this) {
      case WasteCategory.metal:
        return 'معادن (Metal)';
      case WasteCategory.paper:
        return 'ورق وكرتون (Paper)';
      case WasteCategory.glass:
        return 'زجاج (Glass)';
      case WasteCategory.plastic:
        return 'بلاستيك (Plastic)';
    }
  }

  String get englishName {
    switch (this) {
      case WasteCategory.metal:
        return 'Metal';
      case WasteCategory.paper:
        return 'Paper';
      case WasteCategory.glass:
        return 'Glass';
      case WasteCategory.plastic:
        return 'Plastic';
    }
  }

  Color get color {
    switch (this) {
      case WasteCategory.metal:
        return const Color(0xFFF59E0B); // Amber / Yellow
      case WasteCategory.paper:
        return const Color(0xFF3B82F6); // Blue
      case WasteCategory.glass:
        return const Color(0xFF10B981); // Emerald / Green
      case WasteCategory.plastic:
        return const Color(0xFFEF4444); // Red / Orange
    }
  }

  IconData get icon {
    switch (this) {
      case WasteCategory.metal:
        return Icons.inventory_2_outlined;
      case WasteCategory.paper:
        return Icons.menu_book_outlined;
      case WasteCategory.glass:
        return Icons.wine_bar_outlined;
      case WasteCategory.plastic:
        return Icons.local_drink_outlined;
    }
  }

  String get binColorArabic {
    switch (this) {
      case WasteCategory.metal:
        return 'السلة الصفراء / المعدنية';
      case WasteCategory.paper:
        return 'السلة الزرقاء (مخصصة للورق والكرتون)';
      case WasteCategory.glass:
        return 'السلة الخضراء (مخصصة للزجاجيات)';
      case WasteCategory.plastic:
        return 'السلة البرتقالية / الحمراء (للبلاستيك)';
    }
  }

  String get binDescription {
    switch (this) {
      case WasteCategory.metal:
        return 'ضع العنصر في حاوية المعادن، علب الكانز، رقائق الألومنيوم، والأغطية المعدنية.';
      case WasteCategory.paper:
        return 'ضع العنصر في حاوية الورق. تأكد من جفافه وعدم تلوثه بزيوت الأطعمة.';
      case WasteCategory.glass:
        return 'ضع العنصر برفق في حاوية الزجاج لتجنب الكسر أو الأذى، مع إزالة الأغطية.';
      case WasteCategory.plastic:
        return 'ضع العنصر في حاوية البلاستيك بعد تفريغه وضغطه لتوفير مساحة التخزين.';
    }
  }

  String get disposalInstructions {
    switch (this) {
      case WasteCategory.metal:
        return '1. قم بتفريغ أي سوائل أو بقايا أطعمة بالكامل.\n2. اشطف العلبة بالماء لتجنب جذب الحشرات والروائح.\n3. اضغط العلبة أو رقائق الألومنيوم لتوفير مساحة.\n4. لا تخلط البطاريات مع المعادن العادية (البطاريات نفايات خطرة).';
      case WasteCategory.paper:
        return '1. تأكد من خلو الورق أو الكرتون من السوائل والشحوم.\n2. قم بطي الصناديق الكرتونية لتوفير المساحة.\n3. أزل الشرائط اللاصقة البلاستيكية أو المشابك المعدنية إن أمكن.\n4. الأكواب الورقية المبطنة بالشمع أو المناديل المستخدمة تذهب للنفايات العامة.';
      case WasteCategory.glass:
        return '1. اشطف الزجاجة أو البرطمان جيداً من بقايا المحتويات.\n2. افصل الغطاء المعدني أو البلاستيكي وضعه في سلته المخصصة.\n3. لا تخلط زجاج المرايا أو البايركس الحراري مع زجاج الحاويات العادية.\n4. في حال الكسر، غلف القطع بأمان لتفادي إصابة عمال النظافة.';
      case WasteCategory.plastic:
        return '1. أفرغ المحتويات واشطف الزجاجة أو العبوة.\n2. اضغط العبوة البلاستيكية لإخراج الهواء منها وتقليل الحجم.\n3. افصل الغطاء إذا كان رمز التدوير الخاص به مختلفاً.\n4. تأكد من رمز إعادة التدوير (PET 1 أو HDPE 2 هما الأكثر قبولاً).';
    }
  }

  String get environmentalImpact {
    switch (this) {
      case WasteCategory.metal:
        return 'إعادة تدوير علبة ألومنيوم واحدة توفر 95% من الطاقة اللازمة لإنتاج علبة جديدة، وتمنع انبعاث غازات الاحتباس الحراري.';
      case WasteCategory.paper:
        return 'إعادة تدوير طن واحد من الورق ينقذ 17 شجرة، ويوفر 4000 كيلوواط من الكهرباء و26000 لتر من الماء.';
      case WasteCategory.glass:
        return 'الزجاج مادة قابلة لإعادة التدوير بنسبة 100% إلى ما لا نهاية دون فقدان نقائها أو جودتها، ويوفر 30% من استهلاك الطاقة.';
      case WasteCategory.plastic:
        return 'يستغرق البلاستيك أكثر من 450 عاماً ليتحلل! إعادة تدويره تحمي المحيطات والكائنات البحرية وتوفر ثلثي طاقة التصنيع الخام.';
    }
  }

  static WasteCategory fromString(String str) {
    final lower = str.toLowerCase().trim();
    if (lower.contains('metal') || lower.contains('معدن') || lower.contains('حديد') || lower.contains('ألومنيوم')) {
      return WasteCategory.metal;
    }
    if (lower.contains('paper') || lower.contains('cardboard') || lower.contains('ورق') || lower.contains('كرتون')) {
      return WasteCategory.paper;
    }
    if (lower.contains('glass') || lower.contains('زجاج') || lower.contains('إزاز')) {
      return WasteCategory.glass;
    }
    return WasteCategory.plastic;
  }
}

class WasteClassificationResult {
  final String id;
  final String imagePath;
  final WasteCategory category;
  final double confidence; // 0.0 to 1.0
  final String itemName;
  final String explanation;
  final Map<WasteCategory, double> probabilities;
  final DateTime timestamp;
  final bool isRecyclable;
  final String decisionRecommendation;

  WasteClassificationResult({
    required this.id,
    required this.imagePath,
    required this.category,
    required this.confidence,
    required this.itemName,
    required this.explanation,
    required this.probabilities,
    required this.timestamp,
    required this.isRecyclable,
    required this.decisionRecommendation,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imagePath': imagePath,
      'category': category.name,
      'confidence': confidence,
      'itemName': itemName,
      'explanation': explanation,
      'probabilities': probabilities.map((k, v) => MapEntry(k.name, v)),
      'timestamp': timestamp.toIso8601String(),
      'isRecyclable': isRecyclable,
      'decisionRecommendation': decisionRecommendation,
    };
  }

  factory WasteClassificationResult.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> rawProb = json['probabilities'] as Map<String, dynamic>? ?? {};
    final Map<WasteCategory, double> probs = {};
    for (var entry in rawProb.entries) {
      try {
        probs[WasteCategory.values.byName(entry.key)] = (entry.value as num).toDouble();
      } catch (_) {}
    }

    return WasteClassificationResult(
      id: json['id'] ?? '',
      imagePath: json['imagePath'] ?? '',
      category: WasteCategory.values.byName(json['category'] ?? 'plastic'),
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.85,
      itemName: json['itemName'] ?? '',
      explanation: json['explanation'] ?? '',
      probabilities: probs,
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
      isRecyclable: json['isRecyclable'] ?? true,
      decisionRecommendation: json['decisionRecommendation'] ?? '',
    );
  }
}
