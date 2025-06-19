import '../../model/product_model.dart';
import '../../model/search_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts(int limit);
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getProductsByCategorySlug(String slug);
  Future<List<ProductModel>> searchProducts(String query);
  Future<ProductModel> getProductById(int id);
}
