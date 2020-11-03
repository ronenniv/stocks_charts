import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stocks_charts/models/stock_list.dart';
import 'chart_page.dart';
import 'package:provider/provider.dart';
import 'package:stocks_charts/widgets/stocks_list_view.dart';
import 'package:stocks_charts/widgets/add_stock_button.dart';
import 'package:stocks_charts/constants.dart';
import 'package:stocks_charts/widgets/refresh_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StockList(),
      child: Scaffold(
        appBar: AppBar(
          title: kHomeAppBarText,
          actions: [
            RefreshButton(),
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
