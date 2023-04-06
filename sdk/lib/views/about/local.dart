import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'about_title': 'About',
      'about_editorTitle': 'Editor Information',
      'about_company': 'Company',
      'about_address': 'Address',
      'about_version': 'Version',
      'about_userTitle': 'User Information',
    },
    AppLanguge.fr: {
      'about_title': 'A propose de',
      'about_editorTitle': 'Information Editeur',
      'about_company': 'Societe',
      'about_address': 'Adresse',
      'about_version': 'Version',
      'about_userTitle': 'Information utilisateur',
    },
    AppLanguge.zh: {
      'about_title': '关于',
      'about_editorTitle': '软件公司信息',
      'about_company': '公司',
      'about_address': '地址',
      'about_version': '版本',
      'about_userTitle': '用户信息',
    },
    AppLanguge.ko: {
      'about_title': '...에 관하여',
      'about_editorTitle': '프로그램회사 정보',
      'about_company': '회사',
      'about_address': '주소',
      'about_version': '버전',
      'about_userTitle': '사용자 정보',
    },
    AppLanguge.ja: {
      'about_title': '...について',
      'about_editorTitle': '会社情報',
      'about_company': '会社',
      'about_address': '住所',
      'about_version': 'バ－ジョン',
      'about_userTitle': '使用者情報',
    },
  };
  @override
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => 'about_';
}
