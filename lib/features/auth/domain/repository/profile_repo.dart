import '../entitiy/profile_entity.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile();
}