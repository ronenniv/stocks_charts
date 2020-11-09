import 'package:flutter/material.dart';
import 'package:stocks_charts/models/stock.dart';
import 'package:stocks_charts/constants.dart';

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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
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
                      style: kStockSymbolTextStyle,
                    ),
                    Text(
                      stock.lastPrice.toString(),
                      style: kLastPriceTextStyle,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      stock.companyName,
                      style: kCompanyNameTextStyle,
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
