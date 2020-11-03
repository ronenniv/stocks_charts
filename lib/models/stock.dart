import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stocks_charts/constants.dart';

// const kAlphavantageUrl = 'https://www.alphavantage.co';
// const kApiKey = 'SWHTEYQX6EPUOEI8';
const kAPIUrl = 'https://finnhub.io/api/v1';
const kApiKey = 'bua9c7n48v6q418gcc7g';

class Stock with ChangeNotifier {
  String _stockSymbol;
  String _companyName;
  String _companyLogoUrl;
  // String _exchange;
  double _lastPrice;
  double _changeFromClosePrice;

  String get stockSymbol => _stockSymbol;

  set stockSymbol(String stockSymbol) {
    assert(stockSymbol.toUpperCase() == stockSymbol);
    _stockSymbol = stockSymbol;
    notifyListeners();
  }

  String get companyName => _companyName;

  set companyName(String companyName) {
    _companyName = companyName;
    notifyListeners();
  }

  double get lastPrice => _lastPrice;

  double get priceChange => _changeFromClosePrice;

  String get logoUrl => _companyLogoUrl;

  Future<void> getCompanyDetailsFromUrl() async {
    if (_companyName == '' || _companyLogoUrl == '') {
      var response = await http
          .get('$kAPIUrl/stock/profile2?symbol=$_stockSymbol&token=$kApiKey');
      print(
          'urlCompanyName=$kAPIUrl/stock/profile2?symbol=$_stockSymbol&token=$kApiKey');
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse.length > 0) {
          _companyName = jsonResponse['name'];
          _companyName = jsonResponse['name'].length > kMaxCharCompanyName
              ? jsonResponse['name']
                  .substring(0, kMaxCharCompanyName - 1)
                  .trim()
              : jsonResponse['name'];
          _companyLogoUrl = jsonResponse['logo'];
          return;
        }
      }
      // statusCode is error on stock not found
      // if stock not exist Finnhub return code 200 with empty JSON
      print(response.statusCode);
      _companyName = '';
      _companyLogoUrl = '';
    }
  }

  Future<void> getCurrentPrice() async {
    var response =
        await http.get('$kAPIUrl/quote?symbol=$_stockSymbol&token=$kApiKey');
    // print('url=$kAPIUrl/quote?symbol=$_stockSymbol&token=$kApiKey');
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print('jsonResponse=$jsonResponse');
      _lastPrice = jsonResponse['c'].toDouble();
      _changeFromClosePrice = double.parse(
          ((_lastPrice / jsonResponse['pc'].toDouble() * 100) - 100)
              .toDouble()
              .toStringAsFixed(2));
      // print('jsonResponse[c]=' + _lastPrice.toString());
      // print('jsonResponse[pc]=${jsonResponse['pc'].toDouble()}');
    } else {
      print(response.statusCode);
      _lastPrice = 0;
      _changeFromClosePrice = 0;
    }
    notifyListeners();
  }

  Future<void> refreshDetails() async {
    await getCompanyDetailsFromUrl();
    await getCurrentPrice();
  }

  Stock({stockSymbol, companyName = ''}) {
    assert(stockSymbol.toUpperCase() == stockSymbol);
    _stockSymbol = stockSymbol;
    _companyName = companyName;
    _companyLogoUrl = null;
    // _exchange = null;
    _lastPrice = 0;
    _changeFromClosePrice = 0;
  }
}
