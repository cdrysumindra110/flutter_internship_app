part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

// ================= LOGIN =================
class EmailChanged extends AuthEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends AuthEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class TogglePasswordVisibility extends AuthEvent {}

class ToggleRememberMe extends AuthEvent {}

class LoginSubmitted extends AuthEvent {}

// ================= SIGNUP =================
class NameChanged extends AuthEvent {
  final String name;
  const NameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class ConfirmPasswordChanged extends AuthEvent {
  final String value;
  const ConfirmPasswordChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class ToggleConfirmPasswordVisibility extends AuthEvent {}

class SignupSubmitted extends AuthEvent {}