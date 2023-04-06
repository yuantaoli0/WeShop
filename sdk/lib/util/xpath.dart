import 'package:path_provider/path_provider.dart';

class XPath {
  static String? appPath;

  static Future<void> init() async {
    if (appPath == null) {
      final directory = await getApplicationDocumentsDirectory();
      appPath = directory.path;
    }
  }
}
