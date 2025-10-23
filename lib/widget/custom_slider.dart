import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_screen_project/bloc/income_chart/income_cubit.dart';
import 'package:new_screen_project/data/income_data.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _currentSliderValue = dummyIncomeData.length.toDouble();

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _currentSliderValue,
      activeColor: Color(0xFF3E62EC),
      thumbColor: Colors.white,
      max: dummyIncomeData.length.toDouble(),
      divisions: dummyIncomeData.length,
      onChanged: (value) {

        context.read<IncomeCubit>().updateSlider(value);
      },
    );
  }
}
