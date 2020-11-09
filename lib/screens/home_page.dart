import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stocks_charts/models/stock_list.dart';
import 'package:provider/provider.dart';
import 'package:stocks_charts/widgets/home_page/stocks_list_view.dart';
import 'package:stocks_charts/widgets/home_page/add_stock_button.dart';
import 'package:stocks_charts/constants.dart';
import 'package:stocks_charts/widgets/home_page/refresh_button.dart';
import 'package:stocks_charts/models/stocks_file.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StocksFile();

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
