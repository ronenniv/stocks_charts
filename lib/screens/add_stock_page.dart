import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stocks_charts/models/stock.dart';

class AddStockPage extends StatefulWidget {
  @override
  _AddStockPageState createState() => _AddStockPageState();
}

class _AddStockPageState extends State<AddStockPage> {
  String symbolText = '';
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Stock'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: CupertinoTextField(
              showCursor: true,
              placeholder: 'Enter Symbol',
              enableSuggestions: false,
              autocorrect: false,
              textCapitalization: TextCapitalization.characters,
              autofocus: true,
              style: TextStyle(fontSize: 40.0),
              keyboardType: TextInputType.text,
              onChanged: (text) {
                symbolText = text;
                print('text typed is $text');
                if (errorMessage != null) {
                  setState(() {
                    errorMessage = '';
                  });
                }
              },
              // decoration: InputDecoration(
              // hintText: 'Enter Symbol',
            ),
            // hintStyle: TextStyle(color: Colors.black)),
            // ),
          ),
          Text(
            errorMessage,
            style: TextStyle(color: Colors.red),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CupertinoButton(
              color: Colors.lightBlue,
              onPressed: () async {
                print('symbolLength=${symbolText.length}');
                if (symbolText.length > 0) {
                  print('symbolText=$symbolText');
                  Stock stock = Stock(stockSymbol: symbolText);
                  await stock.getCompanyDetailsFromUrl();
                  print('companyNameOnPressed=${stock.companyName}');
                  if (stock.companyName == null) {
                    setState(() {
                      errorMessage = 'Error: Symbol not found';
                    });
                  }
                }
              },
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 40.0, color: Colors.black),
              ),
            ),
          )
        ],
      )),
    );
  }
}
