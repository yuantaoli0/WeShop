import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'terminal_register_title': 'Register teriminal',
      'terminal_register_hid': 'Hid',
      'terminal_register_name': 'Terminal name',
      'terminal_register_input_name': 'Input name for the terminal',
      'terminal_register_ok': 'OK',
    },
    AppLanguge.fr: {
      'terminal_register_title': 'Enregistre terminal',
      'terminal_register_hid': 'Hid:',
      'terminal_register_name': 'Nom',
      'terminal_register_input_name': 'Saisir le nom pour le terminal',
      'terminal_register_ok': 'OK',
    },
    AppLanguge.zh: {
      'terminal_register_title': '注册设备',
      'terminal_register_hid': 'Hid:',
      'terminal_register_name': '设备名称',
      'terminal_register_input_name': '为设备定义名称',
      'terminal_register_ok': 'OK',
    },
    AppLanguge.ko: {
      'terminal_register_title': '설비 등록',
      'terminal_register_hid': 'Hid:',
      'terminal_register_name': '설비 명칭',
      'terminal_register_input_name': '설비명칭 입력',
      'terminal_register_ok': 'OK',
    },
    AppLanguge.ja: {
      'terminal_register_title': '設備を登録',
      'terminal_register_hid': 'Hid:',
      'terminal_register_name': '設備名',
      'terminal_register_input_name': '設備の名前を入力',
      'terminal_register_ok': 'OK',
    },
  };
  @override
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => 'terminal_register_';
}
