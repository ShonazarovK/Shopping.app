import '../../../domain/entities/product.dart';

abstract class CategoryProductState {}

class CategoryInitial extends CategoryProductState {}

class CategoryLoading extends CategoryProductState {}

class CategoryLoaded extends CategoryProductState {
  final List<Product> products;
  CategoryLoaded(this.products);
}

class CategoryError extends CategoryProductState {
  final String message;
  CategoryError(this.message);
}
