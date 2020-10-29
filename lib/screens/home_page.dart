import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stocks_charts/models/stock_list.dart';
import 'chart_page.dart';
import 'package:provider/provider.dart';
import 'package:stocks_charts/widgets/stocks_list_view.dart';
import 'package:stocks_charts/widgets/add_stock_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StockList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Stock Qoutes'),
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  // TODO implement the refresh button
                }),
          ],
        ),
        floatingActionButton: AddStockButton(),
        body: SafeArea(
          child: StocksListView(),
        ),
      ),
    );
  }
}
