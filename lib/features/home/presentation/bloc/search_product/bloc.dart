import 'package:assigment_4/features/home/presentation/bloc/search_product/state.dart';
import 'package:bloc/bloc.dart';

import '../../../domain/usecases/search_usecase.dart';
import '../search_product_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchProductsUseCase searchProductsUseCase;

  SearchBloc(this.searchProductsUseCase) : super(SearchInitial()) {
    on<SearchQueryChanged>((event, emit) async {
      if (event.query.isEmpty) {
        emit(SearchInitial());
        return;
      }

      emit(SearchLoading());

      try {
        final results = await searchProductsUseCase(event.query);
        emit(SearchLoaded(results));
      } catch (e) {
        emit(SearchError('Failed to load search results'));
      }
    });
  }
}