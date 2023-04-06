import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'app_updater_downloaded': 'Downloaded',
      'app_updater_select_install': 'Please install app',
      'app_updater_update_error': 'Error:',
    },
    AppLanguge.fr: {
      'app_updater_downloaded': 'Téléchargé',
      'app_updater_select_install': 'Veuillez installer app',
      'app_updater_update_error': 'Erreur:',
    },
    AppLanguge.zh: {
      'app_updater_downloaded': '下载完成',
      'app_updater_select_install': '请安装app',
      'app_updater_update_error': '错误:',
    },
    AppLanguge.ko: {
      'app_updater_downloaded': '다운로드 완성',
      'app_updater_select_install': '앱을 설치하세요',
      'app_updater_update_error': '에로:',
    },
    AppLanguge.ja: {
      'app_updater_downloaded': 'ダウンロード完成',
      'app_updater_select_install': 'アプリをインストールしてください',
      'app_updater_update_error': '間違い:',
    },
  };
  @override
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => 'app_updater_';
}
