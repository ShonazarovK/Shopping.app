import '../../../domain/entities/product.dart';

abstract class SingleProductState {}

class SingleProductInitial extends SingleProductState {}

class SingleProductLoading extends SingleProductState {}

class SingleProductLoaded extends SingleProductState {
  final Product product;

  SingleProductLoaded(this.product);
}

class SingleProductError extends SingleProductState {
  final String message;

  SingleProductError(this.message);
}
