import 'stock.dart';
import 'package:flutter/material.dart';

class StockList with ChangeNotifier {
  List<Stock> _stockList = [];

  Stock getStock(int index) {
    assert(index >= 0);
    return _stockList[index];
  }

  int get getLength => _stockList.length;

  Stock addStock(Stock stock) {
    assert(stock != null);
    for (var stk in _stockList) {
      if (stk.stockSymbol == stock.stockSymbol) {
        print('stock ${stock.stockSymbol} already exist in list');
        return null;
      }
    }
    stock.refreshDetails();
    _stockList.add(stock);
    notifyListeners();
    return stock;
  }

  void refreshStockPrice() {
    for (Stock stock in _stockList) {
      stock.getCurrentPrice();
    }
    notifyListeners();
  }
}
