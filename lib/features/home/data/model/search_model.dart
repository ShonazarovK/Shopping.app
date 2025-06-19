import 'package:assigment_4/features/home/data/model/product_model.dart';

import '../../domain/entities/search.dart';

class SearchProductModel extends SearchProduct {
  SearchProductModel({required super.products});

  factory SearchProductModel.fromJson(Map<String, dynamic> json) {
    return SearchProductModel(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}