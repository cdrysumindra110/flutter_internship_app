part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, error }

class AuthState extends Equatable {
  // ================= COMMON =================
  final AuthStatus status;

  // ================= LOGIN =================
  final String email;
  final String password;
  final bool obscurePassword;
  final bool rememberMe;

  // ================= SIGNUP =================
  final String name;
  final String confirmPassword;
  final bool obscureConfirmPassword;

  // ================= FIELD ERRORS =================
  final String? nameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;

  const AuthState({
    this.status = AuthStatus.initial,

    this.email = '',
    this.password = '',
    this.obscurePassword = true,
    this.rememberMe = false,

    this.name = '',
    this.confirmPassword = '',
    this.obscureConfirmPassword = true,

    this.nameError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
  });

  AuthState copyWith({
    AuthStatus? status,

    String? email,
    String? password,
    bool? obscurePassword,
    bool? rememberMe,

    String? name,
    String? confirmPassword,
    bool? obscureConfirmPassword,

    String? nameError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
  }) {
    return AuthState(
      status: status ?? this.status,

      email: email ?? this.email,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      rememberMe: rememberMe ?? this.rememberMe,

      name: name ?? this.name,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,

      nameError: nameError,
      emailError: emailError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
    );
  }

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        obscurePassword,
        rememberMe,
        name,
        confirmPassword,
        obscureConfirmPassword,
        nameError,
        emailError,
        passwordError,
        confirmPasswordError,
      ];
}