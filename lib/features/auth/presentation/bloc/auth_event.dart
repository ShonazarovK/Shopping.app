abstract class AuthEvent {
  const AuthEvent();
}

class LoginUser extends AuthEvent {
  final String email;
  final String password;

  const LoginUser({required this.email, required this.password});
}

