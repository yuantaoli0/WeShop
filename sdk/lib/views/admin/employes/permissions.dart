import 'package:sdk/language.dart';
import 'package:sdk/models/terminal.dart';
import 'package:sdk/persmission.dart';
import 'package:sdk/xlocal.dart';

class EmployesPermission extends XPermission {
  static EmployesPermission? instance;

  factory EmployesPermission(double value) {
    instance ??= EmployesPermission._internal(value, Terminal.currentTerminal?.hasPermission('employs') == true);
    return instance!;
  }

  EmployesPermission._internal(double value, bool isPermission) : super('employs', value, isPermission);
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
      "employs_permission_employs": "Employes",
    },
    AppLanguge.fr: {
      "employs_permission_employs": "Employes",
    },
    AppLanguge.zh: {
      "employs_permission_employs": "员工管理",
    },
    AppLanguge.ko: {
      "employs_permission_employs": "Employes",
    }
  };
  @override
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => "employs_permission_";
}
