import '../entitiy/profile_entity.dart';
import '../repository/profile_repo.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<Profile> call() async {
    return await repository.getProfile();
  }
}