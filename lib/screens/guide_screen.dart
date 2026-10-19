import 'package:flutter/material.dart';
import '../models/waste_classification.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          title: const Text(
            'دليل فرز النفايات والتدوير',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF0F172A),
          elevation: 0,
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            indicatorColor: const Color(0xFF10B981),
            indicatorWeight: 3,
            labelColor: const Color(0xFF10B981),
            unselectedLabelColor: Colors.grey.shade600,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            tabs: const [
              Tab(icon: Icon(Icons.inventory_2_outlined), text: 'معادن (Metal)'),
              Tab(icon: Icon(Icons.menu_book_outlined), text: 'ورق (Paper)'),
              Tab(icon: Icon(Icons.wine_bar_outlined), text: 'زجاج (Glass)'),
              Tab(icon: Icon(Icons.local_drink_outlined), text: 'بلاستيك (Plastic)'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCategoryDetail(WasteCategory.metal),
            _buildCategoryDetail(WasteCategory.paper),
            _buildCategoryDetail(WasteCategory.glass),
            _buildCategoryDetail(WasteCategory.plastic),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryDetail(WasteCategory cat) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  cat.color,
                  cat.color.withValues(alpha: 0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: cat.color.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(cat.icon, color: Colors.white, size: 36),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cat.arabicName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        cat.binColorArabic,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Allowed Items vs Forbidden Items
          _buildItemsComparison(cat),

          const SizedBox(height: 16),

          // Bin & Instructions Card
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
                Row(
                  children: [
                    Icon(Icons.checklist, color: cat.color),
                    const SizedBox(width: 8),
                    const Text(
                      'خطوات التحضير الصحيحة:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  cat.disposalInstructions,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.6,
                    color: Color(0xFF334155),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Environmental Impact Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFA7F3D0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.eco, color: Color(0xFF10B981)),
                    SizedBox(width: 8),
                    Text(
                      'لماذا يُعد التدوير ضرورياً؟',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF065F46),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  cat.environmentalImpact,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: Color(0xFF047857),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsComparison(WasteCategory cat) {
    List<String> allowed = [];
    List<String> forbidden = [];

    switch (cat) {
      case WasteCategory.metal:
        allowed = [
          'علب المشروبات الغازية المصنوعة من الألومنيوم',
          'علب حفظ الأغذية المعلبة (التونة، الفول، الطماطم)',
          'رقائق الألومنيوم النظيفة (فويل)',
          'أغطية العبوات والبرطمانات المعدنية',
          'المسامير والأسلاك المعدنية الصغيرة',
        ];
        forbidden = [
          'البطاريات الجافة والهواتف (نفايات خطرة خاصة)',
          'عبوات المواد الكيميائية أو المبيدات',
          'علب الدهانات الملوثة',
        ];
        break;
      case WasteCategory.paper:
        allowed = [
          'صناديق الكرتون والتغليف المفرغة والمطوية',
          'الصحف والمجلات والكتب القديمة',
          'أوراق الطباعة والمكاتب النظيفة',
          'أكياس التسوق الورقية',
          'علب حبوب الإفطار والكرتون المقوى',
        ];
        forbidden = [
          'كرتون البيتزا الملوث ببقايا الزيوت والشحوم',
          'المناديل الورقية المستخدمة والورق الصحي',
          'الأوراق المغلفة بالبلاستيك أو الشمع المقاوم للمياه',
        ];
        break;
      case WasteCategory.glass:
        allowed = [
          'زجاجات المشروبات والعصائر الشفافة والملونة',
          'برطمانات الأغذية (المربى، الصلصة، العسل)',
          'قوارير العطور الفارغة بعد نزع المضخة',
        ];
        forbidden = [
          'زجاج المرايا ونوافذ السيارات والمنازل',
          'أواني البايركس المقاومة للحرارة',
          'المصابيح الكهربائية (تحتوي على غازات ومعادن)',
          'الأكواب والكؤوس الكريستالية',
        ];
        break;
      case WasteCategory.plastic:
        allowed = [
          'زجاجات المياه والعصائر الشفافة (PET 1)',
          'عبوات الشامبو والمنظفات والحليب (HDPE 2)',
          'أوعية الأطعمة وأغطية الزجاجات (PP 5)',
          'أكياس التسوق البلاستيكية النظيفة',
        ];
        forbidden = [
          'أطباق وأكواب الفوم العازلة (الفلين / EPS)',
          'أغلفة الشيبس والحلويات اللامعة متعددة الطبقات',
          'الأنابيب البلاستيكية الصلبة ومخلفات البناء',
        ];
        break;
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Allowed
          Row(
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 20),
              const SizedBox(width: 8),
              Text(
                'عناصر تُوضع في هذه السلة (${cat.englishName}):',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...allowed.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 12.5, color: Color(0xFF334155)),
                      ),
                    ),
                  ],
                ),
              )),
          const Divider(height: 24),
          // Forbidden
          Row(
            children: [
              const Icon(Icons.cancel, color: Colors.red, size: 20),
              const SizedBox(width: 8),
              const Text(
                'عناصر ممنوعة ولا توضع هنا:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...forbidden.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 12.5, color: Color(0xFF334155)),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
