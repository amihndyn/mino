class AuthApi {
  Future<bool> login(
    String email,
    String password,
  ) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    // sementara dummy login
    return email.isNotEmpty &&
        password.isNotEmpty;
  }

  Future<bool> register(
    String email,
    String password,
  ) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    return true;
  }

  Future<void> logout() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );
  }
}