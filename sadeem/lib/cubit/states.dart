class LoginState {
  final bool isLoading;
  final String username;
  final String password;

  LoginState({
    this.isLoading  = false,
      this.username = '',
      this.password = '',
      });

  LoginState copyWith({
    String? username,
    bool? isLoading,
    String? password,
  }) {
    return LoginState(
      isLoading: isLoading??this.isLoading,
      password: password??this.password,
      username: username??this.username
    );

  }
}
