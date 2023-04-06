import 'package:sdk/language.dart';
import 'package:sdk/models/terminal.dart';
import 'package:sdk/persmission.dart';
import 'package:sdk/xlocal.dart';

class TerminalTypesPermission extends XPermission {
  static TerminalTypesPermission? instance;

  factory TerminalTypesPermission(double value) {
    instance ??= TerminalTypesPermission._internal(value, Terminal.currentTerminal!.hasPermission('terminal_types'));
    return instance!;
  }

  TerminalTypesPermission._internal(double value, bool isPermssion) : super('terminal_types', value, isPermssion);
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
      "terminal_types_permission_terminal_types": "Terminals",
    },
    AppLanguge.fr: {
      "terminal_types_permission_terminal_types": "Terminaux",
    },
    AppLanguge.zh: {
      "terminal_types_permission_terminal_types": "终端",
    },
    AppLanguge.ko: {
      "terminal_types_permission_terminal_types": "Terminal Types",
    }
  };
  @override
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => "terminal_types_permission_";
}
