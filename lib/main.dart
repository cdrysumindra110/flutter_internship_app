import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme.dart';
import 'core/router.dart';
import 'core/cubit/theme_cubit.dart';
import 'features/task3/presentation/bloc/post_bloc.dart';
import 'features/task3/data/services/post_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final postService = PostService();
  final prefs = await SharedPreferences.getInstance();

  runApp(MyApp(postService: postService, prefs: prefs));
}

class MyApp extends StatelessWidget {
  final PostService postService;
  final SharedPreferences prefs;

  const MyApp({super.key, required this.postService, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit(prefs: prefs)),

        BlocProvider(create: (_) => PostBloc(postService: postService)),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'Internship Demo',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeState.themeMode,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: AppRouter.home,
          );
        },
      ),
    );
  }
}
