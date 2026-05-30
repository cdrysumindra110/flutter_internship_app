import 'package:flutter/material.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/task1/presentation/screens/profile_screen.dart';
import '../features/task2/presentation/screens/login_screen.dart';
import '../features/task3/presentation/screens/posts_screen.dart';
import '../features/task4/presentation/screens/todo_screen.dart';

class AppRouter {
  static const home = '/';
  static const profile = '/profile';
  static const login = '/login';
  static const posts = '/posts';
  static const todo = '/todo';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case posts:
        return MaterialPageRoute(builder: (_) => const PostsScreen());
      case todo:
        return MaterialPageRoute(builder: (_) => const TodoScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
