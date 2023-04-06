import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'account_title': 'Account',
      'account_login': 'Login',
      'account_passwd': 'Password',
      'account_name': 'Name',
      'account_telephone': 'Telephone',
      'account_card_number': 'Card number',
      'account_terminal_types': 'Terminal types',
      'account_active': 'Active',
      'account_OK': 'OK',
      'account_delete': 'Delete',
      'account_permission_default': 'Default',
      'account_confirmation': 'Confirm',
      'account_confirmationContent': 'Are you sur to delete this account?',
    },
    AppLanguge.fr: {
      'account_title': 'Compte',
      'account_login': 'Identifiant',
      'account_passwd': 'Mots de passe',
      'account_name': 'Nom',
      'account_telephone': 'Telephone',
      'account_card_number': 'N° Carte',
      'account_terminal_types': 'Types de Terminal',
      'account_active': 'Active',
      'account_OK': 'OK',
      'account_delete': 'Supprimer',
      'account_permission_default': 'Defaut',
      'account_confirmation': 'Confirmatioin',
      'account_confirmationContent': 'Vous etes sur de supprimer le compte?',
    },
    AppLanguge.zh: {
      'account_title': '账号',
      'account_login': '账号',
      'account_passwd': '密码',
      'account_name': '姓名',
      'account_telephone': '电话',
      'account_card_number': '员工卡号',
      'account_terminal_types': '设备类型',
      'account_active': '可用',
      'account_OK': 'OK',
      'account_delete': '删除',
      'account_permission_default': '默认',
      'account_confirmation': '不可逆操作',
      'account_confirmationContent': '您确认要删除该账号?',
    },
    AppLanguge.ko: {
      'account_title': '아이디',
      'account_login': '로그인',
      'account_passwd': '비밀번호',
      'account_name': '이름',
      'account_telephone': '전화번호',
      'account_card_number': '직원 카드번호',
      'account_terminal_types': 'Terminal types',
      'account_active': '사용가능',
      'account_OK': 'OK',
      'account_delete': '삭제',
      'account_permission_default': '디폴트',
      'account_confirmation': '확정',
      'account_confirmationContent': '이 아이디를 삭제하겠습니까?',
    },
    AppLanguge.ja: {
      'account_title': 'アカウント',
      'account_login': 'アカウント',
      'account_passwd': 'パスワード',
      'account_name': '名前',
      'account_telephone': '電話',
      'account_card_number': 'クルーズナンバー',
      'account_terminal_types': 'Terminal types',
      'account_active': '使用可能',
      'account_OK': 'OK',
      'account_delete': '消す',
      'account_permission_default': '黙認',
      'account_confirmation': 'Confirm',
      'account_confirmationContent': 'このアカウントを消しますか?',
    },
  };
  @override
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => 'account_';
}
