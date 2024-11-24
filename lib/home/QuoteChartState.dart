import 'package:cripto_grip/home/QuotesChart.dart';
import 'package:cripto_grip/services/coinsService.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class QuoteChartState extends State<QuotesChart>{

  List<LineChartBarData> _chartLines = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    CoinsService().getChartCoins().then((results) {
      List<LineChartBarData> bars = [];
      for (var coinData in results) {
        List<FlSpot> spots = [];
        double index  = 0;
        for (var price in coinData['chartData']['prices']) {
          spots.add(FlSpot(index, price[1]));
          index++;
        }

        bars.add(LineChartBarData(
          barWidth: 3,
          isCurved: true,
          preventCurveOverShooting: true,
          color: _ramdonColor(),
          spots: spots,
        ));
      }
      setState(() {
        _chartLines = bars;
        _isLoading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return !_isLoading? LineChart(
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
            lineBarsData: _chartLines
        ),
        duration: const Duration(microseconds: 150),
        curve: Curves.linear
    ) : const ColoredBox(
        color: Color.fromARGB(100, 224, 172, 94),
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 20 ),
                child: CircularProgressIndicator()),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Loading Quotes')]
            )
          ],
        ));
  }

  _ramdonColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

}