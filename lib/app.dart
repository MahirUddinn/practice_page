import 'package:flutter/material.dart';
import 'package:new_screen_project/bloc/chart_cubit/chart_cubit.dart';
import 'package:new_screen_project/screen/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,

      home: BlocProvider(
        create: (context) => ChartCubit(),
        child: HomeScreen(),
      ),
    );
  }
}
