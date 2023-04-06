import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'request_permission_login': 'Identity',
      'request_permission_passwd': 'Password',
    },
    AppLanguge.fr: {
      'request_permission_login': 'Identifiant',
      'request_permission_passwd': 'Mots de passe',
    },
    AppLanguge.zh: {
      'request_permission_login': '账号',
      'request_permission_passwd': '密码',
    },
    AppLanguge.ko: {
      'request_permission_login': 'Identity',
      'request_permission_passwd': 'Password',
    },
    AppLanguge.ja: {
      'request_permission_login': 'Identity',
      'request_permission_passwd': 'Password',
    },
  };
  @override
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => 'request_permission_';
}
