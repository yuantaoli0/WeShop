import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'server_config_title': 'Server config',
      'server_config_host': 'Host',
      'server_config_port': 'Port',
      'server_config_lance': 'Lance',
    },
    AppLanguge.fr: {
      'server_config_title': 'Configuration de serveur',
      'server_config_host': 'Serveur',
      'server_config_port': 'Porte',
      'server_config_lance': 'Lancer',
    },
    AppLanguge.zh: {
      'server_config_title': '服务器配置',
      'server_config_host': '服务器',
      'server_config_port': '端口',
      'server_config_lance': '启动',
    },
    AppLanguge.ko: {
      'server_config_title': '서버 설정',
      'server_config_host': '서버',
      'server_config_port': '포트',
      'server_config_lance': '시작',
    },
    AppLanguge.ja: {
      'server_config_title': 'サーバー配置',
      'server_config_host': 'サーバー',
      'server_config_port': 'ポート',
      'server_config_lance': '起動',
    },
  };
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => 'server_config_';
}
