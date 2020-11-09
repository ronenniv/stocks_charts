import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stocks_charts/models/stock.dart';
import 'package:stocks_charts/constants.dart';

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
        title: kAddStockAppBarText,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                showCursor: true,
                enableSuggestions: false,
                autocorrect: false,
                textCapitalization: TextCapitalization.characters,
                autofocus: true,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40.0),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: kHintText,
                  errorText: errorMessage,
                  focusedErrorBorder: new OutlineInputBorder(
                      borderSide:
                          new BorderSide(color: Colors.blue, width: 0.0)),
                ),
                onChanged: (text) {
                  symbolText = text;
                  if (errorMessage != null) {
                    setState(() {
                      errorMessage = '';
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CupertinoButton(
                color: Colors.lightBlue,
                onPressed: () async {
                  if (symbolText.length > 0) {
                    Stock stock = Stock(stockSymbol: symbolText);
                    await stock.getCompanyDetailsFromUrl();
                    if (stock.companyName == null || stock.companyName == '') {
                      setState(() {
                        errorMessage = kErrorMessageText;
                      });
                    } else {
                      Navigator.pop(context, stock);
                    }
                  }
                },
                child: Text(
                  'Submit',
                  style: kSubmitButtonTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
