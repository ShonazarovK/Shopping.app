import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';



class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio _dio;

  DioClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://api.escuelajs.co/api/v1',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    if (kIsWeb) {
      _dio.options.sendTimeout = null;
    }

    _dio.interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
      error: true,
    ));
  }

  factory DioClient() => _instance;

  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Tokenni o'chirish
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  /// GET so'rovi
  Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParams,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParams,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  /// POST so'rovi
  Future<Response> post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParams,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParams,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  /// PUT so'rovi
  Future<Response> put(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParams,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParams,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  /// DELETE so'rovi
  Future<Response> delete(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParams,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParams,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }


  /// Dio xatolarini qayta ishlash
  void _handleDioError(DioException e) {
    if (e.response != null) {
      // Serverdan kelgan xato
      print('''
      Dio Error:
      URL: ${e.requestOptions.uri}
      Method: ${e.requestOptions.method}
      Status: ${e.response?.statusCode}
      Message: ${e.response?.statusMessage}
      Response: ${e.response?.data}
      ''');
    } else {
      print('''
      Dio Network Error:
      Message: ${e.message}
      Error: ${e.error}
      ''');
    }
  }
}