import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:assigment_4/features/home/domain/entities/product.dart';
import 'package:assigment_4/features/home/presentation/widgets/product_cardWg.dart';
import 'package:assigment_4/core/common/responsivenes/app_responsicenes.dart';

void main() {
  testWidgets('ProductCard displays title and price correctly', (WidgetTester tester) async {
    final product = Product(
      id: 1,
      title: 'Test Product',
      price: 25.50,
      image: 'https://via.placeholder.com/150',
      description: 'desc',
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            AppResponsive.init(context);
            return Scaffold(
              body: ProductCard(product: product),
            );
          },
        ),
      ),
    );

    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('\$25.50'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
