import '../entities/product.dart';
import '../repositories/product_repo.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<Product>> call(int limit) async {
    return await repository.getProducts(limit);
  }
}