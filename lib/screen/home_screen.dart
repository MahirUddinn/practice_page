import 'package:flutter/material.dart';
import 'package:new_screen_project/widget/income_chart.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_screen_project/bloc/income_chart/income_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IncomeChart(),
            ),
          )
        ],
      ),
    );
  }
}
