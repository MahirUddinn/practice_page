import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_screen_project/bloc/chart_cubit/chart_cubit.dart';
import 'package:new_screen_project/widget/bottom_drawer.dart';
import 'package:new_screen_project/widget/custom_line_chart.dart';
import 'package:new_screen_project/widget/custom_slider.dart';
import 'package:new_screen_project/widget/top_right_dropdown.dart';
import 'package:new_screen_project/bloc/income_chart/income_cubit.dart';

class IncomeChart extends StatefulWidget {
  const IncomeChart({super.key});

  @override
  State<IncomeChart> createState() => _IncomeChartState();
}

class _IncomeChartState extends State<IncomeChart> {
  _buildTab(String name, int index) {
    return GestureDetector(
      onTap: () {
        context.read<ChartCubit>().setIndex(index);
      },
      child: BlocBuilder<ChartCubit, ChartState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            decoration: BoxDecoration(
              color: state.chartIndex == index
                  ? Color(0xFF161825)
                  : Color(0xFF202020),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: state.chartIndex == index
                    ? Color(0xFF5C70B9)
                    : Color(0xFF969696),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildTabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildTab("EPS", 0),
        _buildTab("Revenue", 1),
        _buildTab("EBIT", 2),
        _buildTab("Net Income", 3),
      ],
    );
  }

  _buildTabItems() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTabBar(),
        TopRightDropdown(items: ["Annual", "Quarterly"]),
      ],
    );
  }

  _buildText() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Text("Income", style: TextStyle(fontSize: 24)),
    );
  }

  _buildChart() {
    return BlocBuilder<IncomeCubit, IncomeState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(right: 10),
          height: 250,
          width: double.infinity,
          child: CustomLineChart(incomeData: state.incomeList),
        );
      },
    );
  }

  _buildSlider() {
    return CustomSlider();
  }

  _getInfo(Color color, String text) {
    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color
          ),
        ),
        SizedBox(width: 5,),
        Text(text)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildText(),
        _buildTabItems(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getInfo(Color(0xFF3E62EC), "Current"),
            SizedBox(width: 15),
            _getInfo(Color(0xFF636363), "Previous")
          ],
        ),
        _buildChart(),
        _buildSlider(),
        BottomDrawer(),
      ],
    );
  }
}
