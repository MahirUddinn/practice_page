part of 'income_cubit.dart';

class IncomeState {
  final List<IncomeModel> incomeList;
  final double slideValue;

  IncomeState(
      {required this.incomeList, required this.slideValue});

  IncomeState copyWith({List<IncomeModel>? incomeList, double? slideValue, }) {
    return IncomeState(
      incomeList: incomeList ?? this.incomeList,
      slideValue: slideValue ?? this.slideValue,
    );
  }
}

