import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:assigment_4/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('HomePage dan ProductDetailsPage ga o‘tish testi', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final productCards = find.byType(GestureDetector);

    expect(productCards, findsWidgets);

    await tester.tap(productCards.first);
    await tester.pumpAndSettle();

    expect(find.text('Select Size'), findsOneWidget);
  });
}
