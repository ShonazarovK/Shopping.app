import 'package:assigment_4/features/home/presentation/bloc/category/single_category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_single_products.dart';
import '../category_event.dart';

class CategoryProductBloc extends Bloc<CategoryProductEvent, CategoryProductState> {
  final GetProductsBySlugUseCase useCase;

  CategoryProductBloc(this.useCase) : super(CategoryInitial()) {
    on<FetchCategoryProducts>((event, emit) async {
      emit(CategoryLoading());
      try {
        final products = await useCase(event.slug);
        emit(CategoryLoaded(products));
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });
  }
}
