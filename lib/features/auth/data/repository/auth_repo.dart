import '../../domain/repository/auth_repository.dart';
import '../datasource/remote_datasource/auth_remote_datasource.dart';
import '../model/auth_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) {
    return authRemoteDataSource.login(email: email, password: password);
  }
}

