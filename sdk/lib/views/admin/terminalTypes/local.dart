import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'terminalTypeManager_title': 'Terminals',
      'teminalTypeManager_thisMachine': 'Me',
    },
    AppLanguge.fr: {
      'terminalTypeManager_title': 'Getsion de terminal',
      'teminalTypeManager_thisMachine': 'Moi',
    },
    AppLanguge.zh: {
      'terminalTypeManager_title': '终端管理',
      'teminalTypeManager_thisMachine': '本机',
    },
    AppLanguge.ko: {
      'terminalTypeManager_title': '터미널 관리',
      'teminalTypeManager_thisMachine': '로컬',
    },
    AppLanguge.ja: {
      'terminalTypeManager_title': 'ターミナル管理',
      'teminalTypeManager_thisMachine': '自分',
    },
  };
  @override
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => 'terminalTypeManager_';
}
