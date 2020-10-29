import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stock Chart')),
      body: Center(
        child: Container(
          child: LineChart(LineChartData()),
        ),
      ),
    );
  }
}
