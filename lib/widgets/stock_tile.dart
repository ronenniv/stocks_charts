import 'package:flutter/material.dart';
import 'package:stocks_charts/models/stock.dart';

class StockTile extends StatelessWidget {
  final Stock stock;
  final Function onTapFunc;

  StockTile({@required this.stock, @required this.onTapFunc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        child: Card(
          color: Colors.lightBlueAccent,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      stock.stockSymbol,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40.0),
                    ),
                    Text(
                      stock.lastPrice.toString(),
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      stock.companyName,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      '${stock.priceChange.toString()}%',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: (stock.priceChange >= 0)
                              ? Colors.green
                              : Colors.red),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        onTap: onTapFunc,
      ),
    );
  }
}
