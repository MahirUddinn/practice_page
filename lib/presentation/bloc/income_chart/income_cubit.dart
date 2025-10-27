import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_screen_project/model/income_model.dart';
import 'package:new_screen_project/data/income_data.dart';
import 'package:flutter/material.dart';

part 'income_state.dart';

class IncomeCubit extends Cubit<IncomeState> {
  IncomeCubit()
    : super(
        IncomeState(
          incomeList: dummyIncomeData.sublist(0, 5),
          slideValue: 0,
        ),
      ) {
    updateSlider(0);
  }

  final List<IncomeModel> _fullData = dummyIncomeData;

  void updateSlider(double value) {
    int startIndex = value.toInt();
    int endIndex = startIndex + 5;

    if (startIndex < 0) startIndex = 0;
    if (endIndex > _fullData.length) {
      endIndex = _fullData.length;
      startIndex = endIndex - 5;
    }
    emit(
      state.copyWith(
        slideValue: value,
        incomeList: _fullData.sublist(startIndex, endIndex),
      ),
    );
  }
}
