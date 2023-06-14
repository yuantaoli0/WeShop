import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'go_work': 'go work',
      'off_work': 'Get off work',
      'going_out': 'Going out',
      'overtime': 'Overtime',
      'confirm': 'Confirm'
    },
    AppLanguge.fr: {
      'go_work': 'go work',
      'off_work': 'Get off work',
      'going_out': 'Going out',
      'overtime': 'Overtime',
      'confirm': 'Confirme'
    },
    AppLanguge.zh: {
      'go_work': '上班',
      'off_work': '下班',
      'going_out': '外出',
      'overtime': '加班',
      'confirm': '确认'
    },
    AppLanguge.ko: {
      'go_work': '출근',
      'off_work': '퇴근',
      'going_out': '외출 및 이동',
      'overtime': '초과 근무',
      'confirm': '확인'
    },
    AppLanguge.ja: {
      'go_work': '仕事へ行く',
      'off_work': '仕事を切り上げる',
      'going_out': '外出先から',
      'overtime': '残業時間',
      'confirm': '確認事項'
    },
  };
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => 'clock_';
}
