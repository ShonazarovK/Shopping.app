import '../entities/product.dart';
import '../repositories/product_repo.dart';

class GetSingleProductUseCase {
  final ProductRepository repository;

  GetSingleProductUseCase(this.repository);

  Future<Product> call(int id) async {
    return await repository.getProductById(id);
  }

}
