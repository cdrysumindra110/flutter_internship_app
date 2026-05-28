import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_app/features/task2/presentation/screens/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme.dart';
import '../../../../shared/widgets/loading_button.dart';
import '../bloc/auth_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          showDialog(
            context: context,
            builder: (_) => const AlertDialog(
              title: Text("Success"),
              content: Text("Login successful"),
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [

              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  errorText: state.emailError,
                  prefixIcon: const Icon(Icons.email),
                ),
                onChanged: (v) =>
                    context.read<AuthBloc>().add(EmailChanged(v)),
              ),

              const SizedBox(height: 16),

              TextField(
                obscureText: state.obscurePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  errorText: state.passwordError,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(state.obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () => context
                        .read<AuthBloc>()
                        .add(TogglePasswordVisibility()),
                  ),
                ),
                onChanged: (v) =>
                    context.read<AuthBloc>().add(PasswordChanged(v)),
              ),

              const SizedBox(height: 24),

              LoadingButton(
                label: "Login",
                isLoading: state.status == AuthStatus.loading,
                onPressed: () =>
                    context.read<AuthBloc>().add(LoginSubmitted()),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SignupScreen(),
                      ),
                    ),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}