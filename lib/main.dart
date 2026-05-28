import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme.dart';
import 'core/router.dart';
import 'features/task3/presentation/bloc/post_bloc.dart';
import 'features/task3/data/services/post_service.dart';

void main() {
  // Initialize services
  final postService = PostService();

  runApp(MyApp(postService: postService));
}

class MyApp extends StatelessWidget {
  final PostService postService;

  const MyApp({super.key, required this.postService});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Task 3 BLoC is provided globally so it can be accessed from its screen.
        BlocProvider(create: (_) => PostBloc(postService: postService)),
      ],
      child: MaterialApp(
        title: 'Internship Demo',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system, // can be changed later
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRouter.home,
      ),
    );
  }
}