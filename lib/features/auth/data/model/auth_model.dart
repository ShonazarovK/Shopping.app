import '../../domain/entitiy/auth_token.dart';

class AuthModel extends Auth {
   AuthModel({required String accessToken, required String refreshToken})
    : super(accessToken: accessToken, refreshToken: refreshToken);

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'access_token': accessToken, 'refresh_token': refreshToken};
  }
}
