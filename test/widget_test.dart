import 'package:flutter_test/flutter_test.dart';
import 'package:smart_waste_ai/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SmartWasteAIApp());
    expect(find.text('Smart Waste AI'), findsWidgets);
  });
}
