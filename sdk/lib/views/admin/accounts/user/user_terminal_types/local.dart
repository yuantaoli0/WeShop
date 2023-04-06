import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'user_terminal_types_title': 'Terminal types',
      'user_terminal_types_OK': 'OK',
    },
    AppLanguge.fr: {
      'user_terminal_types_title': 'Types de Terminal',
      'user_terminal_types_OK': 'OK',
    },
    AppLanguge.zh: {
      'user_terminal_types_title': '设备类型',
      'user_terminal_types_OK': 'OK',
    },
    AppLanguge.ko: {
      'user_terminal_types_title': 'Types de Terminal',
      'user_terminal_types_OK': 'OK',
    },
    AppLanguge.ja: {
      'user_terminal_types_title': 'Types de Terminal',
      'user_terminal_types_OK': 'OK',
    },
  };
  @override
  Map<String, Map<String, String>> get keys => _dict;

  @override
  String get name => 'user_terminal_types_';
}
