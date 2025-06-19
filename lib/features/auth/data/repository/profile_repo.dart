// lib/features/profile/data/repositories/profile_repository_impl.dart
import '../../../../core/network/server_exeption.dart';
import '../../domain/entitiy/profile_entity.dart';
import '../../domain/repository/profile_repo.dart';
import '../datasource/remote_datasource/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Profile> getProfile() async {
    try {
      final profile = await remoteDataSource.getProfile();
      return profile;
    } catch (e) {
      throw ServerException(message: 'Profile repository error: $e');
    }
  }
}