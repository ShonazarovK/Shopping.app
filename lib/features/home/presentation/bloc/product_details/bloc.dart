import 'package:assigment_4/features/home/presentation/bloc/product_details/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/product_details_usecase.dart';
import '../product_details_event.dart';


class SingleProductBloc extends Bloc<SingleProductEvent, SingleProductState> {
  final GetSingleProductUseCase useCase;

  SingleProductBloc(this.useCase) : super(SingleProductInitial()) {
    on<FetchSingleProduct>((event, emit) async {
      emit(SingleProductLoading());
      try {
        final product = await useCase(event.id);
        emit(SingleProductLoaded(product));
      } catch (e) {
        emit(SingleProductError(e.toString()));
      }
    });
  }
}
