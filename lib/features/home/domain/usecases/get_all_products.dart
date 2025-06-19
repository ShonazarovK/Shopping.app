import '../entities/product.dart';
import '../repositories/product_repo.dart';

class GetAllProductsUseCase {
  final ProductRepository repository;
  GetAllProductsUseCase(this.repository);

  Future<List<Product>> call() => repository.getAllProducts();
}
