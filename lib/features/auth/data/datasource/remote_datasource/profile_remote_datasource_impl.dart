import 'package:assigment_4/features/auth/data/datasource/remote_datasource/profile_remote_datasource.dart';
import 'package:dio/dio.dart';

import '../../../../../core/network/dio_client.dart';
import '../../../../../core/network/server_exeption.dart';
import '../../model/profile_model.dart';
import '../local_datasource/auth_local_datasource.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioClient dioClient;
  final AuthLocalDataSource authLocalDataSource;

  ProfileRemoteDataSourceImpl({
    required this.dioClient,
    required this.authLocalDataSource,
  });

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final tokens = await authLocalDataSource.getAuthToken();
      print(
          "DEBUG: Retrieved Tokens: $tokens"); // Tokenlarni konsolda ko'rsatish

      if (tokens['access_token']?.isEmpty ?? true) {
        throw Exception('Access token mayjud emas');
      }

      final response = await dioClient.get(
        '/auth/profile',
        options: Options(headers: {
          'Authorization': 'Bearer ${tokens['access_token']}'
        }),
      );
      return ProfileModel.fromJson(response.data);
    } catch (e) {
      throw ServerException(message: 'Profil maʼlumotlarini olishda xato: $e');
    }
  }}