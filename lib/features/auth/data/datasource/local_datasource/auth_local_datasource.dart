abstract class AuthLocalDataSource {
  //! Remember me
  Future<void> saveRememberMe(String email, String password);

  Future<Map<String, String>> getRemembered();

  Future<void> clearRememberedCredentials();

  //! Token
  Future<Map<String, String>> getAuthToken();

  Future<void> saveAuthToken(String refreshToken, String accessToken);

  Future<void> clearAuthToken();
}

