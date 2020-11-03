import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:stocks_charts/models/stock.dart';
import 'package:stocks_charts/constants.dart';

class ChartPage extends StatelessWidget {
  final Stock stock;

  ChartPage({@required this.stock});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: kChartAppBarText),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: SfCartesianChart(),
        ),
      ),
    );
  }
}
