import 'package:sdk/language.dart';
import 'package:sdk/persmission.dart';
import 'package:sdk/xlocal.dart';

class ServerConfigPermission extends XPermission {
  static ServerConfigPermission? instance;

  factory ServerConfigPermission(double value) {
    instance ??= ServerConfigPermission._internal(value);
    return instance!;
  }

  ServerConfigPermission._internal(double value) : super('server_config', value, true);

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
      "server_config_permission_server_config": "Server Config",
    },
    AppLanguge.fr: {
      "server_config_permission_server_config": "Configuration de server",
    },
    AppLanguge.zh: {
      "server_config_permission_server_config": "服务器配置",
    },
    AppLanguge.ko: {
      "server_config_permission_server_config": "Server Config",
    }
  };
  @override
  Map<String, Map<String, String>> get keys => _dict;

  @override
  String get name => "server_config_permission_";
}
