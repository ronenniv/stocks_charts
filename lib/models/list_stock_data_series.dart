import 'stock_data_series.dart';
import 'stock.dart';

class ListStockDataSeries {
  Stock _stock;

  List<StockDataSeries> valueDataStockSeries = [
    StockDataSeries('Mon', 110.3, 2000),
    StockDataSeries('Tue', 85.6, 7000),
    StockDataSeries('Wed', 106.33, 6000),
    StockDataSeries('Thu', 101.25, 3000),
    StockDataSeries('Fri', 100.45, 5000),
  ];

  ListStockDataSeries(this._stock);

  String get stockSymbol => _stock.stockSymbol;
  String get companyName => _stock.companyName;
}
