import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/router.dart';
import '../../../../core/cubit/theme_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internship Tasks'),
        actions: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              final isDarkMode =
                  Theme.of(context).brightness == Brightness.dark;
              return IconButton(
                icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
                tooltip: isDarkMode ? 'Light Mode' : 'Dark Mode',
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TaskButton(
                label: 'Task 1 – Profile Page',
                onTap: () => Navigator.pushNamed(context, AppRouter.profile),
              ),
              const SizedBox(height: 16),
              TaskButton(
                label: 'Task 2 – Login Page',
                onTap: () => Navigator.pushNamed(context, AppRouter.login),
              ),
              const SizedBox(height: 16),
              TaskButton(
                label: 'Task 3 – API Integration',
                onTap: () => Navigator.pushNamed(context, AppRouter.posts),
              ),
              const SizedBox(height: 16),
              TaskButton(
                label: 'Task 4 – To-Do CRUD App',
                onTap: () => Navigator.pushNamed(context, AppRouter.todo),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const TaskButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
