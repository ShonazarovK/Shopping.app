import '../entities/product.dart';
import '../repositories/product_repo.dart';

class GetProductsBySlugUseCase {
  final ProductRepository repository;
  GetProductsBySlugUseCase(this.repository);

  Future<List<Product>> call(String slug) => repository.getProductsBySlug(slug);
}
