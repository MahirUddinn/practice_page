import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_screen_project/model/income_model.dart';
import 'package:new_screen_project/data/income_data.dart';

part 'income_state.dart';

class IncomeCubit extends Cubit<IncomeState> {
  IncomeCubit()
      : super(IncomeState(
    incomeList: [],
    slideValue: 0,
  ));

  void updateSlider(double value) {
    emit(state.copyWith(slideValue: value));
  }
}