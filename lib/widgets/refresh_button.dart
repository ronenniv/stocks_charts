import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stocks_charts/models/stock_list.dart';

class RefreshButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var stocks = Provider.of<StockList>(context);

    return IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () {
          stocks.refreshStockPrice();
        });
  }
}
