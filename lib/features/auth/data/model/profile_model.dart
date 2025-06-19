import '../../domain/entitiy/profile_entity.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required String name,
    required String email,
    required String role,
  }) : super(name: name, email: email, role: role);

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }
}