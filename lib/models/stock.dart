import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// const kAlphavantageUrl = 'https://www.alphavantage.co';
// const kApiKey = 'SWHTEYQX6EPUOEI8';
const kAPIUrl = 'https://finnhub.io/api/v1';
const kApiKey = 'bua9c7n48v6q418gcc7g';

class Stock with ChangeNotifier {
  String _stockSymbol;
  String _companyName;
  String _companyLogoUrl;
  String _exchange;
  double _lastPrice;
  double _changeFromClosePrice;

  String get stockSymbol => _stockSymbol;

  set stockSymbol(String stockSymbol) {
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
      // print(
      //     'urlCompanyName=$kAPIUrl/stock/profile2?symbol=$_stockSymbol&token=$kApiKey');
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        _companyName = jsonResponse['name'];
        _companyLogoUrl = jsonResponse['logo'];
        // print('jsonResponse[name]=${jsonResponse['name']}');
        // print('jsonResponse[logo]=${jsonResponse['logo']}');
      } else {
        print(response.statusCode);
        _companyName = '';
        _companyLogoUrl = '';
      }
    }
  }

  void getCurrentPrice() async {
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
  }

  void refreshDetails() {
    getCompanyDetailsFromUrl();
    getCurrentPrice();
  }

  Stock({stockSymbol, companyName = ''}) {
    _stockSymbol = stockSymbol;
    _companyName = companyName;
    _companyLogoUrl = null;
    _exchange = null;
    _lastPrice = 0;
    _changeFromClosePrice = 0;
  }
}
