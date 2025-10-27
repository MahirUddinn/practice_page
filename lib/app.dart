import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_screen_project/presentation/bloc/chart_cubit/chart_cubit.dart';
import 'package:new_screen_project/presentation/bloc/income_chart/income_cubit.dart';
import 'package:new_screen_project/presentation/screen/home_screen.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,

      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ChartCubit()),
          BlocProvider(create: (context) => IncomeCubit()),
        ],
        child: HomeScreen(),
      ),
    );
  }
}
