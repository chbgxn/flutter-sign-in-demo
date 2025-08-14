class SignInState {
  final String email;
  final String password;
  final String emailError;
  final String passwordError;
  final bool buttonEnable;

  SignInState({
    this.email = '', 
    this.password = '', 
    this.emailError = '', 
    this.passwordError = '',
    this.buttonEnable = false
  });

  SignInState copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    bool? buttonEnable
  }){
    return SignInState(
      email: email ?? this.email, 
      password: password ?? this.password,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      buttonEnable: buttonEnable ?? this.buttonEnable
    );
  }
}