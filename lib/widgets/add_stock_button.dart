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
            String snackBarText;
            if (stocks.addStock(result) == null) {
              snackBarText = 'Stock ${result.stockSymbol} already exist';
            } else {
              snackBarText = '${result.stockSymbol} added to the list';
            }
            final snackBar = SnackBar(
                content: Text(
              snackBarText,
              style: TextStyle(fontSize: 24.0),
            ));
            Scaffold.of(context).showSnackBar(snackBar);
          }
        });
  }
}
