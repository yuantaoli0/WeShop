import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'ask_one_time_password_cancel': 'Cancel',
      'ask_one_time_password_ok': 'OK',
    },
    AppLanguge.fr: {
      'ask_one_time_password_cancel': 'Annuler',
      'ask_one_time_password_ok': 'OK',
    },
    AppLanguge.zh: {
      'ask_one_time_password_cancel': '取消',
      'ask_one_time_password_ok': '确认',
    },
    AppLanguge.ko: {
      'ask_one_time_password_cancel': '취소',
      'ask_one_time_password_ok': '확인',
    },
    AppLanguge.ja: {
      'ask_one_time_password_cancel': '取消',
      'ask_one_time_password_ok': '確認',
    }
  };
  Map<String, Map<String, String>> get keys => _dict;

  @override
  String get name => 'ask_one_time_password_';
}
