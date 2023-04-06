import 'dart:io';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import 'format.dart';

class XLogger {
  static final XLogger instance = new XLogger._internal();

  factory XLogger() {
    return instance;
  }

  Logger? logger;
  XLogger._internal() {
    logger = Logger(
      printer: PrettyPrinter(),
      filter: WSXLogFilter(),
      output: WSXLoggerOutput(),
    );
  }

  v(dynamic verboseMsg) {
    logger?.v(verboseMsg);
  }

  d(dynamic debugMsg) {
    logger?.d(debugMsg);
  }

  i(dynamic infoMsg) {
    logger?.i(infoMsg);
  }

  w(dynamic warningMsg) {
    logger?.w(warningMsg);
  }

  e(dynamic errorMsg) {
    logger?.e(DateTime.now().toString() + ":" + errorMsg);
  }

  wtf(dynamic terribleMsg) {
    logger?.wtf(terribleMsg);
  }
}

class WSXLoggerOutput extends LogOutput {
  String? path = '';
  @override
  Future<void> output(OutputEvent event) async {
    Directory? directory;
    if (path == '') {
      directory = await getApplicationDocumentsDirectory();
      path = directory!.path;
      for (var itm in directory.listSync()) {
        if (itm.path.contains('log') && (DateTime.now().difference(itm.statSync().modified).inDays > 5)) {
          try {
            itm.deleteSync();
          } catch (ex) {
            print(ex.toString());
          }
        }
      }
    }
    print(event.lines.join('\n'));
    if (event.level.index > Level.warning.index) {
      //var path = XPath.appPath;
      if (path != null) {
        try {
          String name = '/log-' + format.intlDate(DateTime.now()) + '.txt';
          var out = File(path! + name).openWrite(mode: FileMode.append);
          //var file = File(path! + '/logs.txt');
          out.write(event.lines.join('\n'));
          await out.close();
        } catch (ex) {
          print(ex.toString());
        }
      }
    }
  }
}

class WSXLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}
