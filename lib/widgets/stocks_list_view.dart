import 'package:flutter/material.dart';
import 'stock_tile.dart';
import 'package:stocks_charts/models/stock_list.dart';
import 'package:provider/provider.dart';

class StocksListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var stocks = Provider.of<StockList>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ListView.builder(
        itemCount: stocks.getLength,
        itemBuilder: (context, index) {
          return StockTile(
              stock: stocks.getStock(index),
              onTapFunc: () {
                print('onTap $index');
              });
        },
        padding: EdgeInsets.all(8.0),
      ),
    );
  }
}
