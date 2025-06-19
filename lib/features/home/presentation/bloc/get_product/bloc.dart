
import 'package:assigment_4/features/home/presentation/bloc/get_product/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/product_usecase.dart';
import '../product_event.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;

  ProductBloc(this.getProductsUseCase) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await getProductsUseCase(event.limit);
        emit(ProductLoaded(products: products));
      } catch (e) {
        emit(ProductError(message: 'Failed to load products'));
      }
    });
  }
}