import 'package:flutter/material.dart';
import 'package:stocks_charts/models/stock.dart';
import 'package:stocks_charts/models/stock_list.dart';
import 'package:provider/provider.dart';
import 'package:stocks_charts/screens/add_stock_page.dart';

class AddStockButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var stocks = Provider.of<StockList>(context);

    return FloatingActionButton(
        mini: true,
        child: Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.push(
              context,
              MaterialPageRoute<Stock>(
                  builder: (BuildContext context) => AddStockPage()));

          if (result != null) {
            stocks.addStock(result);
          }
        });
  }
}
