import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'login_title': 'Connection',
      'login_login': 'Login',
      'login_passwd': 'Password',
      'login_ok': 'OK',
      'login_exit': 'Exit',
    },
    AppLanguge.fr: {
      'login_title': 'Connexion',
      'login_login': 'Identifiant',
      'login_passwd': 'Mots de passe',
      'login_ok': 'OK',
      'login_exit': 'Quitter',
    },
    AppLanguge.zh: {
      'login_title': '登录',
      'login_login': '账号',
      'login_passwd': '密码',
      'login_ok': '登录',
      'login_exit': '退出',
    },
    AppLanguge.ko: {
      'login_title': '로그인',
      'login_login': '아이디',
      'login_passwd': '비빌번호',
      'login_ok': '등록',
      'login_exit': '나가기',
    },
    AppLanguge.ja: {
      'login_title': 'ログイン',
      'login_login': 'アカウント',
      'login_passwd': 'パスワード',
      'login_ok': 'ログイン',
      'login_exit': 'ログアウト',
    },
  };
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => 'login_';
}
