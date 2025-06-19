import '../../../domain/entities/product.dart';

abstract class AllProductState {}

class AllProductInitial extends AllProductState {}

class AllProductLoading extends AllProductState {}

class AllProductLoaded extends AllProductState {
  final List<Product> products;
  AllProductLoaded(this.products);
}

class AllProductError extends AllProductState {
  final String message;
  AllProductError(this.message);
}
