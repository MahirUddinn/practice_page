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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeCubit, IncomeState>(
      builder: (context, state) {
        return SliderTheme(
          data: SliderThemeData(
            activeTrackColor: Color(0xFF3E62EC),
            inactiveTrackColor: Color(0xFFA8A8A8),
            overlayColor: Color(0xFF3E62EC),
            activeTickMarkColor: Colors.transparent,
            inactiveTickMarkColor: Colors.transparent,
          ),
          child: Slider(

            value: state.slideValue,
            thumbColor: Colors.white,
            min: 0,
            max: dummyIncomeData.length.toDouble() - 5,
            divisions: dummyIncomeData.length - 5,
            onChanged: (value) {
              context.read<IncomeCubit>().updateSlider(value);
            },
          ),
        );
      },
    );
  }
}
