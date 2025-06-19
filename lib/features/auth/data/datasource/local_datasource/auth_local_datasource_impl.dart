import 'package:hive_flutter/adapters.dart';

import 'auth_local_datasource.dart';
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box box;

  AuthLocalDataSourceImpl({required this.box});

  @override
  @override
  Future<void> saveAuthToken(String refreshToken, String accessToken) async {
    print("DEBUG: Tokens Saved - Access: $accessToken, Refresh: $refreshToken");
    await box.put('access_token', accessToken);
    await box.put('refresh_token', refreshToken);
  }
  @override
  Future<Map<String, String>> getAuthToken() async {
    final accessToken = box.get('access_token', defaultValue: '');
    final refreshToken = box.get('refresh_token', defaultValue: '');

    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  @override
  Future<void> clearAuthToken() async {
    await box.delete('access_token');
    await box.delete('refresh_token');
  }

  @override
  Future<void> clearRememberedCredentials() async {
    await box.delete('email');
    await box.delete('password');
  }

  @override
  Future<Map<String, String>> getRemembered() async {
    final email = box.get('email', defaultValue: '');
    final password = box.get('password', defaultValue: '');
    return {'email': email, 'password': password};
  }
  @override
  Future<void> saveRememberMe(String email, String password) async {
    await box.put('email', email);
    await box.put('password', password);
  }
}