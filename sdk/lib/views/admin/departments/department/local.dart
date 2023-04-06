import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'department_title': 'Department',
      'department_name': 'Name',
      'department_active': 'Active',
      'department_comment': 'Comment',
      'department_OK': 'OK',
    },
    AppLanguge.fr: {
      'department_title': 'Department',
      'department_name': 'Nom',
      'department_active': 'Active',
      'department_OK': 'OK',
    },
    AppLanguge.zh: {
      'department_title': '部门',
      'department_name': '名称',
      'department_active': '可用',
      'department_OK': 'OK',
    },
    AppLanguge.ko: {
      'department_title': 'Department',
      'department_name': 'Name',
      'department_active': 'Active',
      'department_OK': 'OK',
    },
    AppLanguge.ja: {
      'department_title': 'Department',
      'department_name': 'Name',
      'department_active': 'Active',
      'department_OK': 'OK',
    }
  };
  @override
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => 'department_';
}
