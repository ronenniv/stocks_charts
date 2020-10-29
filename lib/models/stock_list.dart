import 'stock.dart';
import 'package:flutter/material.dart';

class StockList with ChangeNotifier {
  List<Stock> _stockList = [];

  Stock getStock(int index) {
    assert(index >= 0);
    return _stockList[index];
  }

  int get getLength => _stockList.length;

  void addStock(Stock stock) {
    assert(stock != null);
    for (var stk in _stockList) {
      if (stk.stockSymbol == stock.stockSymbol) {
        print('stock ${stock.stockSymbol} already exasit in list');
        return;
      }
    }
    stock.refreshDetails();
    _stockList.add(stock);
    notifyListeners();
  }
}
