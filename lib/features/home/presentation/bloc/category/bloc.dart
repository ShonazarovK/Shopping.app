import 'package:assigment_4/features/home/presentation/bloc/category/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_all_products.dart';
import '../all_category_event.dart';

class AllProductBloc extends Bloc<AllProductEvent, AllProductState> {
  final GetAllProductsUseCase useCase;

  AllProductBloc(this.useCase) : super(AllProductInitial()) {
    on<FetchAllProducts>((event, emit) async {
      emit(AllProductLoading());
      try {
        final products = await useCase();
        emit(AllProductLoaded(products));
      } catch (e) {
        emit(AllProductError(e.toString()));
      }
    });
  }
}
