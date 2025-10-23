part of 'income_cubit.dart';

class IncomeState{
 final List<IncomeModel> incomeList;

  IncomeState({required this.incomeList});

 IncomeState copyWith({List<IncomeModel>? incomeList}) {
   return IncomeState(incomeList: incomeList ?? this.incomeList);
 }
}