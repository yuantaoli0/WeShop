import 'package:sdk/language.dart';
import 'package:sdk/models/terminal.dart';
import 'package:sdk/persmission.dart';
import 'package:sdk/xlocal.dart';

class AboutsPermission extends XPermission {
  static AboutsPermission? instance;

  factory AboutsPermission(double value) {
    instance ??= AboutsPermission._internal(value, Terminal.currentTerminal?.hasPermission('about') == true);
    return instance!;
  }

  AboutsPermission._internal(double value, bool isPermission) : super('about', value, isPermission);
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
      "about_permission_about": "About",
    },
    AppLanguge.fr: {
      "about_permission_about": "A propose de",
    },
    AppLanguge.zh: {
      "about_permission_about": "关于",
    },
    AppLanguge.ko: {
      "about_permission_about": "About",
    }
  };
  @override
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => "about_permission_";
}
