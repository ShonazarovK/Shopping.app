import '../entities/product.dart';
import '../entities/search.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts(int limit);
  Future<List<Product>> searchProducts(String query);
  Future<List<Product>> getAllProducts();
  Future<List<Product>> getProductsBySlug(String slug);
  Future<Product> getProductById(int id);
}

