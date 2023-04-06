import 'package:sdk/language.dart';
import 'package:sdk/models/terminal.dart';
import 'package:sdk/persmission.dart';
import 'package:sdk/xlocal.dart';

class AccountsPermission extends XPermission {
  static AccountsPermission? instance;

  factory AccountsPermission(double value) {
    instance ??= AccountsPermission._internal(value, Terminal.currentTerminal?.hasPermission('accounts') == true);
    return instance!;
  }

  AccountsPermission._internal(double value, bool isPermission) : super('accounts', value, isPermission);
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
      "accounts_permission_accounts": "Accounts",
    },
    AppLanguge.fr: {
      "accounts_permission_accounts": "Comptes",
    },
    AppLanguge.zh: {
      "accounts_permission_accounts": "账号",
    },
    AppLanguge.ko: {
      "accounts_permission_accounts": "Accounts",
    }
  };
  @override
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => "accounts_permission_";
}
