import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_screen_project/data/income_data.dart';
import 'package:new_screen_project/presentation/widget/top_right_dropdown.dart';
import '../bloc/chart_cubit/chart_cubit.dart';
import '../bloc/income_chart/income_cubit.dart';
import 'bottom_drawer.dart';
import 'custom_line_chart.dart';
import 'custom_slider.dart';

class IncomeChart extends StatefulWidget {
  const IncomeChart({super.key});

  @override
  State<IncomeChart> createState() => _IncomeChartState();
}

class _IncomeChartState extends State<IncomeChart> {
  final ScrollController _scrollController = ScrollController();
  int? _lastSpec;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final currentOffset = _scrollController.offset;
      final maxExtent = _scrollController.position.maxScrollExtent;
      final spec = (((dummyIncomeData.length - 5) / maxExtent) * currentOffset)
          .toInt();
      if (_lastSpec != spec) {
        _lastSpec = spec;
        context.read<IncomeCubit>().updateSlider(spec.toDouble());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildText(),
        _buildTabItems(),
        _buildLegend(),
        _buildChart(),
        _buildSlider(),
        Container(padding: EdgeInsets.all(8), child: _buildBottomTable()),
      ],
    );
  }

  Widget _buildTab(String name, int index) {
    return GestureDetector(
      onTap: () {
        context.read<ChartCubit>().setIndex(index);
      },
      child: BlocBuilder<ChartCubit, ChartState>(
        builder: (context, state) {
          final selected = state.chartIndex == index;
          return Container(
            margin: const EdgeInsets.all(2),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xFF161825)
                  : const Color(0xFF202020),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: selected
                    ? const Color(0xFF5C70B9)
                    : const Color(0xFF969696),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabBar() {
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

  Widget _buildTabItems() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTabBar(),
          const TopRightDropdown(items: ["Annual", "Quarterly"]),
        ],
      ),
    );
  }

  Widget _buildText() {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: const Text("Income", style: TextStyle(fontSize: 24)),
    );
  }

  Widget _buildChart() {
    return BlocBuilder<IncomeCubit, IncomeState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(right: 10),
          height: 250,
          width: double.infinity,
          child: CustomLineChart(incomeData: state.incomeList),
        );
      },
    );
  }

  Widget _buildSlider() {
    return CustomSlider(onChange: context.read<IncomeCubit>().updateSlider);
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(const Color(0xFF3E62EC), "Current"),
        const SizedBox(width: 15),
        _buildLegendItem(const Color(0xFF636363), "Previous"),
      ],
    );
  }

  Widget _buildBottomTable() {
    return BlocBuilder<IncomeCubit, IncomeState>(
      buildWhen: (p, c) => p.slideValue != c.slideValue,
      builder: (context, state) {
        // if (_scrollController.hasClients) {
        //   final isUserScrolling =
        //       _scrollController.position.isScrollingNotifier.value;
        //   if (!isUserScrolling) {
        //     _scrollController.animateTo(
        //       state.slideValue,
        //       duration: const Duration(milliseconds: 300),
        //       curve: Curves.easeOut,
        //     );
        //   }
        // }
        return BottomDrawer(scrollController: _scrollController);
      },
    );
  }
}
