import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_app/features/task2/presentation/screens/signup_screen.dart';
import '../../../../shared/widgets/loading_button.dart';
import '../bloc/auth_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputDecoration = InputDecoration(
      filled: false,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      hintStyle: theme.textTheme.bodyMedium?.copyWith(
        color: theme.textTheme.bodySmall?.color?.withOpacity(0.65),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: theme.colorScheme.onSurface.withOpacity(0.35),
          width: 1,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: theme.colorScheme.onSurface.withOpacity(0.35),
          width: 1,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: theme.colorScheme.primary,
          width: 2,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
    );

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Row(
                children: [
                  const Icon(Icons.check_circle_outline, color: Colors.green),
                  const SizedBox(width: 12),
                  Text(
                    'Success',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
              content: Text(
                'You have successfully logged in. Welcome back!',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: inputDecoration.copyWith(
                hintText: 'Username/Email',
                errorText: state.emailError,
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (v) => context.read<AuthBloc>().add(EmailChanged(v)),
            ),

            const SizedBox(height: 16),

            TextField(
              obscureText: state.obscurePassword,
              decoration: inputDecoration.copyWith(
                hintText: 'Password',
                errorText: state.passwordError,
                suffixIcon: IconButton(
                  icon: Icon(
                    state.obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () => context.read<AuthBloc>().add(
                    TogglePasswordVisibility(),
                  ),
                ),
              ),
              onChanged: (v) => context.read<AuthBloc>().add(PasswordChanged(v)),
            ),

            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                ),
                child: const Text('Forgot password?'),
              ),
            ),

            const SizedBox(height: 18),

            LoadingButton(
              label: 'Login',
              isLoading: state.status == AuthStatus.loading,
              onPressed: () => context.read<AuthBloc>().add(LoginSubmitted()),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: theme.textTheme.bodyMedium,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignupScreen()),
                  ),
                  child: Text(
                    'Register',
                    style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
