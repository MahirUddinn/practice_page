import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chart_state.dart';

class ChartCubit extends Cubit<ChartState> {
  ChartCubit() : super(ChartState(chartIndex: 0));
  void setIndex(int index){
    emit(state.copyWith(chartIndex: index));
  }
}
