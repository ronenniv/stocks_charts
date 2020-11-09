import 'dart:io';
import 'package:stocks_charts/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stocks_charts/models/stock.dart';
import 'package:stocks_charts/models/stock_list.dart';

class StocksFile {
  File fileHandler;
  static const String kFieldDivider = '|';

  StocksFile() {
    initializeFile();
  }

  Future<void> initializeFile() async {
    final directory =
        await getApplicationDocumentsDirectory(); // get local path
    final fileHandler = File(directory.path + kStocksFilename);
    await fileHandler.writeAsString('AAPL|Apple Inc\n', flush: true);
    await fileHandler.writeAsString('DOX|Amdocs Inc\n',
        mode: FileMode.append, flush: true);

    var line = await fileHandler.readAsLines();
    print('line=$line, line len=${line.length}');
    line = await fileHandler.readAsLines();
    for (var ln in line) {
      print('$ln');
    }
  }

  void saveToFile(Stock stock) {
    fileHandler.writeAsString(
        stock.stockSymbol + kFieldDivider + stock.companyName,
        mode: FileMode.append,
        flush: true);
  }
}
