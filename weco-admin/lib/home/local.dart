import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'clock_login': 'please clock in',
      'error_title': 'Error',
      'error': 'card not recognized. Please make sure your card is correct and try again.'
    },
    AppLanguge.fr: {
      'clock_login': 'Veuillez pointer',
    },
    AppLanguge.zh: {
      'clock_login': '请打卡',
    },
    AppLanguge.ko: {
      'clock_login': '출근하세요',
    },
    AppLanguge.ja: {
      'clock_login': 'クロックイン',
    },
  };
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => 'clock_';
}
