import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme.dart';
import '../../../../shared/widgets/loading_button.dart';
import '../bloc/auth_bloc.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Success"),
              content: const Text("Account created successfully!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [

              // ================= NAME =================
              TextField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: const Icon(Icons.person_outlined),
                  errorText: state.nameError,
                ),
                onChanged: (v) =>
                    context.read<AuthBloc>().add(NameChanged(v)),
              ),

              const SizedBox(height: 16),

              // ================= EMAIL =================
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  errorText: state.emailError,
                ),
                onChanged: (v) =>
                    context.read<AuthBloc>().add(EmailChanged(v)),
              ),

              const SizedBox(height: 16),

              // ================= PASSWORD =================
              TextField(
                obscureText: state.obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outlined),
                  errorText: state.passwordError,
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

              const SizedBox(height: 16),

              // ================= CONFIRM PASSWORD =================
              TextField(
                obscureText: state.obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock_outlined),
                  errorText: state.confirmPasswordError,
                  suffixIcon: IconButton(
                    icon: Icon(state.obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () => context
                        .read<AuthBloc>()
                        .add(ToggleConfirmPasswordVisibility()),
                  ),
                ),
                onChanged: (v) => context
                    .read<AuthBloc>()
                    .add(ConfirmPasswordChanged(v)),
              ),

              const SizedBox(height: 24),

              // ================= BUTTON =================
              LoadingButton(
                label: 'Create Account',
                isLoading: state.status == AuthStatus.loading,
                onPressed: () =>
                    context.read<AuthBloc>().add(SignupSubmitted()),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: GoogleFonts.poppins(fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "Login",
                      style: GoogleFonts.poppins(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}