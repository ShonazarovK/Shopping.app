import 'package:assigment_4/features/home/data/datasource/remote/product_remote_data_source.dart';
import 'package:dio/dio.dart';

import '../../../../../core/network/dio_client.dart';
import '../../../../../core/network/server_exeption.dart';
import '../../../domain/entities/product.dart';
import '../../model/product_model.dart';
import '../../model/search_model.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioClient dioClient;

  ProductRemoteDataSourceImpl(this.dioClient);

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await dioClient.get('/products/$id');
      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromDioError(e);
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final response = await dioClient.get(
        '/products/',
        queryParams: {'title': query},
      );

      return (response.data as List)
          .map((json) => ProductModel.fromJson(json))
          .toList(); // ✅ Bu List<Product>
    } on DioException catch (e) {
      throw ServerException.fromDioError(e);
    }
  }
  @override
  Future<List<ProductModel>> getAllProducts() async {
    final res = await dioClient.get('/products');
    return (res.data as List).map((e) => ProductModel.fromJson(e)).toList();
  }

  @override
  Future<List<ProductModel>> getProductsByCategorySlug(String slug) async {
    final res = await dioClient.get('/products', queryParams: {'categorySlug': slug});
    return (res.data as List).map((e) => ProductModel.fromJson(e)).toList();
  }

  @override
  Future<List<ProductModel>> getProducts(int limit) async {
    try {
      final response = await dioClient.get(
        '/products',
        queryParams: {'limit': limit},
      );

      return (response.data as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ServerException.fromDioError(e);
    }
  }
}