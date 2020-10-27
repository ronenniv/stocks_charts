import 'package:flutter/material.dart';
import 'stock.dart';

class StockList {
  List<Stock> _stockList = [];

  Stock getStock(int index) {
    return _stockList[index];
  }

  void addStock(Stock stock) {
    stock.refreshDetails();
    _stockList.add(stock);
  }

  int get getLength => _stockList.length;
}
