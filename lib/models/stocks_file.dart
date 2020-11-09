import 'dart:io';
import 'package:stocks_charts/constants.dart';
import 'package:path_provider/path_provider.dart';

class StocksFile {
  StocksFile() {
    initializeFile();
  }

  Future<String> initializeFile() async {
    final directory =
        await getApplicationDocumentsDirectory(); // get local path
    final file = File(directory.path + kStocksFilename);
    //print('directory.path=${directory.path + kStocksFilename}');
    //file.create();
    await file.writeAsString('AAPL|Apple Inc\n', flush: true);
    await file.writeAsString('DOX|Amdocs Inc\n',
        mode: FileMode.append, flush: true);
    //file.writeAsStringSync('DOX|Amdocs Inc\n', mode: FileMode.append);

    var line = await file.readAsLines();
    print('line=$line, line len=${line.length}');
    line = await file.readAsLines();
    for (var ln in line) {
      print('$ln');
    }

    return directory.path;
  }
}
