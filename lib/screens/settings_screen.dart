import 'package:flutter/material.dart';
import '../services/gemini_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _apiKeyController = TextEditingController();
  bool _isLoading = true;
  bool _obscureKey = true;

  @override
  void initState() {
    super.initState();
    _loadKey();
  }

  Future<void> _loadKey() async {
    final key = await GeminiClassifierService.getApiKey();
    if (key != null) {
      _apiKeyController.text = key;
    }
    setState(() => _isLoading = false);
  }

  Future<void> _saveKey() async {
    await GeminiClassifierService.setApiKey(_apiKeyController.text);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم حفظ مفتاح Gemini بنجاح!'),
          backgroundColor: Color(0xFF10B981),
        ),
      );
    }
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'الإعدادات ونظام الدعم الذكي',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // AI Engine Settings Card
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.psychology, color: Color(0xFF10B981)),
                            SizedBox(width: 8),
                            Text(
                              'إعدادات محرك الذكاء الاصطناعي (AI Engine)',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'يعمل التطبيق بنظام هجين (Hybrid Mode):\n'
                          '1. Gemini Vision AI: عند توفر مفتاح API وإنترنت لتحليل فائق الدقة مع تقديم توصيات DSS متقدمة.\n'
                          '2. On-Device Vision Engine: يعمل محلياً بالكامل على الهاتف بدون إنترنت للتعرف على المواد (Metal, Paper, Glass, Plastic).',
                          style: TextStyle(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _apiKeyController,
                          obscureText: _obscureKey,
                          decoration: InputDecoration(
                            labelText: 'مفتاح Google Gemini API Key (اختياري)',
                            hintText: 'AIzaSy...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureKey ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () => setState(() => _obscureKey = !_obscureKey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: _saveKey,
                          icon: const Icon(Icons.save, color: Colors.white),
                          label: const Text(
                            'حفظ المفتاح',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF10B981),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            minimumSize: const Size(double.infinity, 46),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Project Information (Decision Support System)
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.school_outlined, color: Color(0xFF3B82F6)),
                            SizedBox(width: 8),
                            Text(
                              'عن المشروع الأكاديمي (Project Details)',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _infoRow('اسم التطبيق:', 'Smart Waste AI'),
                        _infoRow('المادة الدراسية:', 'Decision Support System (نظم دعم القرار)'),
                        _infoRow('المستوى والفرقة:', 'Level 4 • Semester 7'),
                        _infoRow('الهدف الأساسي:', 'فرز وتصنيف النفايات الذكي (Metal, Paper, Glass, Plastic) باستخدام الكاميرا والذكاء الاصطناعي لدعم اتخاذ قرار التدوير السليم.'),
                        _infoRow('إصدار التطبيق:', 'v1.0.0+1'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Waste Category Legend
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ألوان حاويات الفرز المعيارية في التطبيق:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _legendRow(const Color(0xFFF59E0B), 'معادن (Metal)', 'السلة الصفراء'),
                        _legendRow(const Color(0xFF3B82F6), 'ورق وكرتون (Paper)', 'السلة الزرقاء'),
                        _legendRow(const Color(0xFF10B981), 'زجاج (Glass)', 'السلة الخضراء'),
                        _legendRow(const Color(0xFFEF4444), 'بلاستيك (Plastic)', 'السلة الحمراء / البرتقالية'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 12.5, color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _legendRow(Color color, String name, String bin) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          const Spacer(),
          Text(bin, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        ],
      ),
    );
  }
}
