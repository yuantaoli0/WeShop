import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'employeManager_title': 'Employes',
    },
    AppLanguge.fr: {
      'employeManager_title': 'Employes',
    },
    AppLanguge.zh: {
      'employeManager_title': '员工管理',
    },
    AppLanguge.ko: {
      'employeManager_title': 'Employes',
    },
    AppLanguge.ja: {
      'employeManager_title': 'Employes',
    }
  };
  @override
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => 'employeManager_';
}
