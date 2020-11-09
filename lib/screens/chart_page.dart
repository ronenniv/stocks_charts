import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stocks_charts/models/stock.dart';
import 'package:stocks_charts/constants.dart';
import 'package:stocks_charts/models/list_stock_data_series.dart';
import 'package:stocks_charts/widgets/chart_page/stock_line_chart.dart';

class ChartPage extends StatefulWidget {
  final Stock stock;

  ChartPage({@required this.stock});

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  ListStockDataSeries listStockDataSeries;
  Future<bool> _getData;

  void initState() {
    super.initState();
    assert(widget.stock != null);
    assert(widget.stock.stockSymbol != null);
    assert(widget.stock.companyName != null);
    listStockDataSeries = ListStockDataSeries(widget.stock);
    _getData = listStockDataSeries.loadDataSeries();
  }

  @override
  Widget build(BuildContext context) {
    bool flagLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(title: kChartAppBarText),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: FutureBuilder(
            future: _getData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return StockLineChart(
                  stockDataSeries: listStockDataSeries,
                  flagLandscape: flagLandscape,
                );
              } else {
                return CupertinoActivityIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
