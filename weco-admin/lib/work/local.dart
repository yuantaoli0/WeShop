import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'go_work': 'go work',

    },
    AppLanguge.fr: {
      'go_work': 'go work',

    },
    AppLanguge.zh: {
      'go_work': '上班',

    },
    AppLanguge.ko: {
      'go_work': '출근',
      
    },
    AppLanguge.ja: {
      'go_work': '仕事へ行く',

    },
  };
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => 'clock_';
}
