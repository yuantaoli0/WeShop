import 'package:sdk/language.dart';
import 'package:sdk/models/terminal.dart';
import 'package:sdk/persmission.dart';
import 'package:sdk/xlocal.dart';

class DepartmentsPermission extends XPermission {
  static DepartmentsPermission? instance;

  factory DepartmentsPermission(double value) {
    instance ??= DepartmentsPermission._internal(value, Terminal.currentTerminal?.hasPermission('departments') == true);
    return instance!;
  }

  DepartmentsPermission._internal(double value, bool isPermission) : super('departments', value, isPermission);
  @override
  XBaseLocal get local => _Local();
}

class _Local extends XBaseLocal {
  static final _Local _instance = _Local._internal();
  _Local._internal();
  factory _Local() {
    return _instance;
  }
  final _dict = {
    AppLanguge.en: {
      "departments_permission_employs": "Departments",
    },
    AppLanguge.fr: {
      "departments_permission_employs": "Departments",
    },
    AppLanguge.zh: {
      "departments_permission_employs": "部门管理",
    },
    AppLanguge.ko: {
      "departments_permission_employs": "Departments",
    }
  };
  @override
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => "departments_permission_";
}
