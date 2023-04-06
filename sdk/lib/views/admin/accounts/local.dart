import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'accountManager_title': 'Accounts',
      'accountManager_copy': 'Copy',
    },
    AppLanguge.fr: {
      'accountManager_title': 'Gestion de Compte',
      'accountManager_copy': 'Copier',
    },
    AppLanguge.zh: {
      'accountManager_title': '账号管理',
      'accountManager_copy': '复制',
    },
    AppLanguge.ko: {
      'accountManager_title': '아이디 관리',
      'accountManager_copy': 'Copy',
    },
    AppLanguge.ja: {
      'accountManager_title': 'アカウント管理',
      'accountManager_copy': 'Copy',
    }
  };
  @override
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => 'accountManager_';
}
