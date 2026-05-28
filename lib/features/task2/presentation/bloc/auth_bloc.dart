import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {

    // ================= LOGIN =================
    on<EmailChanged>((e, emit) {
      emit(state.copyWith(email: e.email, status: AuthStatus.initial));
    });

    on<PasswordChanged>((e, emit) {
      emit(state.copyWith(password: e.password, status: AuthStatus.initial));
    });

    on<TogglePasswordVisibility>((e, emit) {
      emit(state.copyWith(obscurePassword: !state.obscurePassword));
    });

    on<ToggleRememberMe>((e, emit) {
      emit(state.copyWith(rememberMe: !state.rememberMe));
    });

    on<LoginSubmitted>(_login);

    // ================= SIGNUP =================
    on<NameChanged>((e, emit) {
      emit(state.copyWith(name: e.name, status: AuthStatus.initial));
    });

    on<ConfirmPasswordChanged>((e, emit) {
      emit(state.copyWith(
        confirmPassword: e.value,
        status: AuthStatus.initial,
      ));
    });

    on<ToggleConfirmPasswordVisibility>((e, emit) {
      emit(state.copyWith(
        obscureConfirmPassword: !state.obscureConfirmPassword,
      ));
    });

    on<SignupSubmitted>(_signup);
  }

  // ================= LOGIN VALIDATION =================
  Future<void> _login(LoginSubmitted e, Emitter<AuthState> emit) async {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

    String? emailError;
    String? passwordError;

    if (!emailRegex.hasMatch(state.email)) {
      emailError = "Enter valid email";
    }

    if (state.password.length < 8) {
      passwordError = "Password must be at least 8 characters";
    }

    if (emailError != null || passwordError != null) {
      emit(state.copyWith(
        status: AuthStatus.error,
        emailError: emailError,
        passwordError: passwordError,
      ));
      return;
    }

    emit(state.copyWith(status: AuthStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: AuthStatus.success));
  }

  // ================= SIGNUP VALIDATION =================
  Future<void> _signup(SignupSubmitted e, Emitter<AuthState> emit) async {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

    String? nameError;
    String? emailError;
    String? passwordError;
    String? confirmPasswordError;

    if (state.name.trim().length < 3) {
      nameError = "Name must be at least 3 characters";
    }

    if (!emailRegex.hasMatch(state.email)) {
      emailError = "Enter valid email";
    }

    if (state.password.length < 8) {
      passwordError = "Password must be at least 8 characters";
    }

    if (state.password != state.confirmPassword) {
      confirmPasswordError = "Passwords do not match";
    }

    if (nameError != null ||
        emailError != null ||
        passwordError != null ||
        confirmPasswordError != null) {
      emit(state.copyWith(
        status: AuthStatus.error,
        nameError: nameError,
        emailError: emailError,
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError,
      ));
      return;
    }

    emit(state.copyWith(status: AuthStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: AuthStatus.success));
  }
}