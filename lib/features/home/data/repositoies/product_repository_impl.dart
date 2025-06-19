
import '../../../../core/network/server_exeption.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/search.dart';
import '../../domain/repositories/product_repo.dart';
import '../datasource/remote/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Product> getProductById(int id) async {
    return await remoteDataSource.getProductById(id);
  }

  @override
  Future<List<Product>> getProducts(int limit) async {
    try {
      final products = await remoteDataSource.getProducts(limit);
      return products;
    } on ServerException {
      rethrow;
    }
  }
  @override
  Future<List<Product>> getAllProducts() => remoteDataSource.getAllProducts();

  @override
  Future<List<Product>> getProductsBySlug(String slug) =>
      remoteDataSource.getProductsByCategorySlug(slug);

  @override
  Future<List<Product>> searchProducts(String query) async {
    try {
      final products = await remoteDataSource.searchProducts(query);
      return products; // ✅ Bu yerda ProductModel → Product bo‘lgan holatda qaytadi
    } on ServerException {
      rethrow;
    }
  }}
