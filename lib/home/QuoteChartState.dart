import 'package:cripto_grip/home/QuotesChart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class QuoteChartState extends State<QuotesChart>{

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
          borderData: FlBorderData(show: false),
          titlesData: const FlTitlesData(
            topTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: false
            )),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false)
            )
          ),
          lineBarsData: [
            LineChartBarData(
              barWidth: 3,
              isCurved: true,
              preventCurveOverShooting: true,
              color: Colors.black,
              spots: const [
                FlSpot(0, 1.5),
                FlSpot(1, 3.2),
                FlSpot(2, 4.35),
                FlSpot(3, 2.24),
              ],
            )
      ]),
      duration: const Duration(microseconds: 150),
      curve: Curves.linear
    );
  }
}