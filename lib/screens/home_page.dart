import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stocks_charts/models/stock_list.dart';
import 'package:stocks_charts/models/stock.dart';
import 'package:stocks_charts/screens/add_stock_page.dart';
import 'package:stocks_charts/widgets/stock_tile.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StockList stocks = StockList();
    stocks.addStock(Stock(stockSymbol: 'AAPL'));
    //stocks.getStock(0).getCompanyNameFromUrl();
    //stocks.getStock(0).getCurrentPrice();
    //print('HomePage ' + stocks.getStock(0).companyName);
    stocks.addStock(Stock(stockSymbol: 'DOX', companyName: 'Amdocs INC'));

    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Qoutes'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => AddStockPage()));
            },
          ),
        ],
      ),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: [
            StockTile(stock: stocks.getStock(0)),
            StockTile(stock: stocks.getStock(1)),
          ],
        ),
      ),
    );
  }
}
