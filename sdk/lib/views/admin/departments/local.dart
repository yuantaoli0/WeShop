import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'departmentManager_title': 'Departments',
    },
    AppLanguge.fr: {
      'departmentManager_title': 'Departments',
    },
    AppLanguge.zh: {
      'departmentManager_title': '部门管理',
    },
    AppLanguge.ko: {
      'departmentManager_title': 'Departments',
    },
    AppLanguge.ja: {
      'departmentManager_title': 'Departments',
    }
  };
  @override
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => 'departmentManager_';
}
