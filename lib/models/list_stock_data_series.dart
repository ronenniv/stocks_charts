import 'dart:convert';
import 'stock_data_series.dart';
import 'stock.dart';
import 'package:http/http.dart' as http;

const String alphavantageApiKey = 'SWHTEYQX6EPUOEI8';
const String alphavantageUrl =
    'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED';

class ListStockDataSeries {
  Stock _stock;

  List<StockDataSeries> valueDataStockSeries = [];

  ListStockDataSeries(this._stock);

  String get stockSymbol => _stock.stockSymbol;
  String get companyName => _stock.companyName;

  int getHighestVolume() {
    int highest = 0;
    if (valueDataStockSeries.length > 0) {
      for (StockDataSeries dataSeries in valueDataStockSeries) {
        if (dataSeries.volume > highest) {
          highest = dataSeries.volume;
        }
      }
    }
    return highest;
  }

  String _toDateOnly(DateTime dateTimeValue) {
    // conver to format yyyy-mm-dd
    assert(dateTimeValue != null);
    return dateTimeValue.toString().substring(0, 10);
  }

  String _toMonthDayOnly(DateTime dateTimeValue) {
    // conver to format mm-dd
    assert(dateTimeValue != null);
    return dateTimeValue.toString().substring(5, 10);
  }

  Future<bool> loadDataSeries() async {
    String getDataSeriesUrl =
        '$alphavantageUrl&symbol=${_stock.stockSymbol}&apikey=$alphavantageApiKey';
    print('dataSeriesUrl=$getDataSeriesUrl');
    var response = await http.get(getDataSeriesUrl);
    if (response.statusCode == 200) {
      var initialDate = DateTime.parse(
          jsonDecode(response.body)['Meta Data']['3. Last Refreshed']);
      print('initialDate=$initialDate');
      for (int i = 0; i < 7; i++) {
        String fetchDateString = _toDateOnly(initialDate);
        var responseClose = jsonDecode(response.body)['Time Series (Daily)']
            [fetchDateString]['4. close'];
        var responseVolume = jsonDecode(response.body)['Time Series (Daily)']
            [fetchDateString]['6. volume'];
        valueDataStockSeries.add(StockDataSeries(_toMonthDayOnly(initialDate),
            double.tryParse(responseClose), int.tryParse(responseVolume)));
        print(
            'responseData=$responseClose, $responseVolume, date=${_toMonthDayOnly(initialDate)}');

        // check the next date has data
        do {
          initialDate = initialDate.subtract(Duration(days: 1));
        } while (jsonDecode(response.body)['Time Series (Daily)']
                [_toDateOnly(initialDate)] ==
            null);
      }
      valueDataStockSeries = valueDataStockSeries.reversed
          .toList(); // reverse the order to older to newer
      return true; // data series loaded
    } else {
      print('statusCode=${response.statusCode}');
      return false;
    }
  }
}
