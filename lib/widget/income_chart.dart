import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_screen_project/bloc/chart_cubit/chart_cubit.dart';
import 'package:new_screen_project/data/income_data.dart';
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
  final ScrollController _scrollController = ScrollController();

  static const int _visibleItems = 5;

  int? _lastSpec;
  bool _isAnimating = false;
  DateTime _lastUpdate = DateTime.fromMillisecondsSinceEpoch(0);
  static const int _minUpdateIntervalMs = 40;

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
    if (_isAnimating) return;
    if (!_scrollController.hasClients) return;
    final now = DateTime.now();
    if (now.difference(_lastUpdate).inMilliseconds < _minUpdateIntervalMs) {
      return;
    }
    _lastUpdate = now;

    final maxExtent = _scrollController.position.maxScrollExtent;
    if (maxExtent <= 0) return;

    final totalMovable = (dummyIncomeData.length - _visibleItems).clamp(0, dummyIncomeData.length).toDouble();
    if (totalMovable <= 0) return;

    final currentOffset = _scrollController.offset.clamp(0.0, maxExtent);
    final specDouble = (currentOffset / maxExtent) * totalMovable;
    final spec = specDouble.round();

    if (_lastSpec != spec) {
      _lastSpec = spec;
      context.read<IncomeCubit>().updateSlider(spec.toDouble());
    }
  }

  Future<void> _animateToSlide(double slideValue) async {
    if (!_scrollController.hasClients) return;
    if (_isAnimating) return;

    final maxExtent = _scrollController.position.maxScrollExtent;
    if (maxExtent <= 0) return;

    final totalMovable = (dummyIncomeData.length - _visibleItems).clamp(0, dummyIncomeData.length).toDouble();
    if (totalMovable <= 0) return;

    if (_scrollController.position.isScrollingNotifier.value) return;

    final normalized = (slideValue / totalMovable).isFinite ? (slideValue / totalMovable) : 0.0;
    double targetOffset = (normalized * maxExtent).clamp(0.0, maxExtent);

    _isAnimating = true;
    try {
      await _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } finally {
      _isAnimating = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(padding: const EdgeInsets.all(8), child: _buildText()),
        Container(padding: const EdgeInsets.all(8), child: _buildTabItems()),
        _buildLegend(),
        _buildChart(),
        _buildSlider(),
        Container(
          padding: EdgeInsets.all(8),
          child: BlocListener<IncomeCubit, IncomeState>(
            listenWhen: (previous, current) => previous.slideValue != current.slideValue,
            listener: (context, state) {
              _animateToSlide(state.slideValue);
            },
            child: BottomDrawer(scrollController: _scrollController),
          ),
        ),
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
              color: selected ? const Color(0xFF161825) : const Color(0xFF202020),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: selected ? const Color(0xFF5C70B9) : const Color(0xFF969696),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTabBar(),
        const TopRightDropdown(items: ["Annual", "Quarterly"]),
      ],
    );
  }

  Widget _buildText() {
    return Container(
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

  Widget _getLegend(Color color, String text) {
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
        _getLegend(const Color(0xFF3E62EC), "Current"),
        const SizedBox(width: 15),
        _getLegend(const Color(0xFF636363), "Previous"),
      ],
    );
  }
}
