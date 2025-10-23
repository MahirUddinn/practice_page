part of 'chart_cubit.dart';

class ChartState {
  int chartIndex;

  ChartState({required this.chartIndex});

  ChartState copyWith({int? chartIndex}) {
    return ChartState(chartIndex: chartIndex ?? this.chartIndex);
  }
}