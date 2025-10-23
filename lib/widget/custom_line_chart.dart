import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:new_screen_project/data/income_data.dart';

class CustomLineChart extends StatefulWidget {
  const CustomLineChart({super.key, required this.data});

  final List<FlSpot> data;

  @override
  State<CustomLineChart> createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LineChart(
        LineChartData(
          gridData: _buildGridData(),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            _buildLineChartBarData1(),
            _buildLineChartBarData2()
          ],
          titlesData: _buildTilesData(),
          minY: -1,
          maxY: 1

        ),
      ),
    );
  }

  FlTitlesData _buildTilesData(){
    return FlTitlesData(
      bottomTitles: _buildBottomTitles(),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: _buildLeftTitles(),

    );
  }

  FlGridData _buildGridData() {
    return FlGridData(drawVerticalLine: false);
  }

  LineChartBarData _buildLineChartBarData1() {
    return LineChartBarData(
      spots: dummyIncomeData.asMap().entries
          .map((e) => FlSpot(e.key.toDouble(), e.value.current))
          .toList(),
      color: Color(0xFF3E62EC),
      aboveBarData: BarAreaData(
        spotsLine: BarAreaSpotsLine(show: false)
      )
    );
  }
  LineChartBarData _buildLineChartBarData2() {
    return LineChartBarData(
      spots: dummyIncomeData.asMap().entries
          .map((e) => FlSpot(e.key.toDouble(), e.value.previous))
          .toList(),
      color: Color(0xFF656565),
    );
  }

  AxisTitles _buildLeftTitles(){
    return AxisTitles(
      sideTitles: SideTitles(
        minIncluded: false,
        maxIncluded: false,
        reservedSize: 50,
        showTitles: true,

      )
    );
  }

  AxisTitles _buildBottomTitles() {
    return AxisTitles(
      sideTitles: SideTitles(
        reservedSize: 15,
        maxIncluded: true,
        interval:3,
        getTitlesWidget: (value, meta) {
          var index = value.toInt();
          return  Text(
            dummyIncomeData[index].date,
            style: const TextStyle(color: Colors.white, fontSize: 10),
          );
        },
        showTitles: true,
      ),
    );
  }
}
