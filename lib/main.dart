
import 'package:enpal/bloc/cubit/theme/theme_cubit.dart';
import 'package:enpal/bloc/cubit/theme/theme_state.dart';
import 'package:enpal/helper/bloc_init_helper.dart';
import 'package:enpal/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {

 
  runApp(
    BlocProvider(
      create: (context) => ThemeCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Theme Toggle App',
          theme: state.themeData,
          home: const MainScreen(),
        );
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return initCoreBlocs(HomeScreen());
  }
}
