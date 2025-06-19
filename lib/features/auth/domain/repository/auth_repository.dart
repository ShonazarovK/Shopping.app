import '../entitiy/auth_token.dart';

abstract class AuthRepository {
  Future<Auth> login({
    required String email,
    required String password,
  });
}

