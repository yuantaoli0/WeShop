import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'expired_information_title': 'Expired',
      'expired_information_content': 'Please contact weshop',
      'expired_information_OK': 'OK',
      'expired_information_cancel': 'Cancel',
    },
    AppLanguge.fr: {
      'expired_information_title': 'Expiré',
      'expired_information_content': 'Veuillez contacter WESHOP pour avoir le code de deblocage',
      'expired_information_OK': 'OK',
      'expired_information_cancel': 'Annuler',
    },
    AppLanguge.zh: {
      'expired_information_title': '过期提醒',
      'expired_information_content': '请联系WESHOP公司,获取解锁码',
      'expired_information_OK': '确认',
      'expired_information_cancel': '取消',
    },
    AppLanguge.ko: {
      'expired_information_title': 'Votre license est expiré',
      'expired_information_content': 'Veuillez contacter WESHOP pour avoir le code de deblocage',
      'expired_information_OK': 'OK',
      'expired_information_cancel': 'Annuler',
    }
  };
  @override
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => 'expired_information_';
}
