
import 'package:assigment_4/features/home/data/model/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductModel Test', () {
    test('fromJson should return valid ProductModel instance', () {
      final json = {
        "id": 1,
        "title": "Test Product",
        "price": 29.99,
        "images": ["https://example.com/image.jpg"],
        "description": "Test description"
      };

      final product = ProductModel.fromJson(json);

      expect(product.id, 1);
      expect(product.title, "Test Product");
      expect(product.price, 29.99);
      expect(product.image, "https://example.com/image.jpg");
      expect(product.description, "Test description");
    });

    test('fromJson should handle missing description', () {
      final json = {
        "id": 2,
        "title": "Another Product",
        "price": 19.99,
        "images": ["https://example.com/img2.jpg"],
      };

      final product = ProductModel.fromJson(json);

      expect(product.id, 2);
      expect(product.title, "Another Product");
      expect(product.price, 19.99);
      expect(product.image, "https://example.com/img2.jpg");
      expect(product.description, "");
    });
  });
}