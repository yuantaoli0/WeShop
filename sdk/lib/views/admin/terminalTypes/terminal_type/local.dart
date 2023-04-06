import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'terminal_type_title': 'Terminal Type',
      'terminal_type_payments': 'Payments',
      'terminal_type_limit': 'Terminal limit',
      'terminal_type_autoCreateCart': 'Auto create cart(XMenu)',
      'terminal_type_autoValidation': 'Auto valid cart(XMenu)',
      'terminal_type_showSuggestions': 'Show Suggestions',
      'terminal_type_displayAmount': 'Show Amount',
      'terminal_type_block_timeout': 'Waiting time',
      'terminal_type_services': 'Services',
      'terminal_type_init_category': 'Init Category',
      'terminal_type_categories': 'Categories',
      'terminal_type_OK': 'OK',
    },
    AppLanguge.fr: {
      'terminal_type_title': 'Type de Terminal',
      'terminal_type_payments': 'Paiements',
      'terminal_type_limit': 'Nombre de terminal',
      'terminal_type_autoCreateCart': 'Auto creer panier(XMenu)',
      'terminal_type_autoValidation': 'Auto valider panier(XMenu)',
      'terminal_type_showSuggestions': 'Afficher Propositions',
      'terminal_type_displayAmount': 'Afficher montant',
      'terminal_type_block_timeout': 'Delais d\'attent',
      'terminal_type_services': 'Services',
      'terminal_type_init_category': 'Categorie init.',
      'terminal_type_categories': 'Categories',
      'terminal_type_OK': 'OK',
    },
    AppLanguge.zh: {
      'terminal_type_title': '设备类型',
      'terminal_type_payments': '支付方式',
      'terminal_type_limit': '设备数量',
      'terminal_type_autoCreateCart': '自行建单(XMenu)',
      'terminal_type_autoValidation': '自行发送(XMenu)',
      'terminal_type_showSuggestions': '推荐产品',
      'terminal_type_displayAmount': '显示总价',
      'terminal_type_block_timeout': '等待时间',
      'terminal_type_services': '服务类型',
      'terminal_type_init_category': '初始目录',
      'terminal_type_categories': '目录',
      'terminal_type_OK': '保存',
    },
    AppLanguge.ko: {
      'terminal_type_title': '설비 유형',
      'terminal_type_payments': '결제방법',
      'terminal_type_limit': 'Terminal limit',
      'terminal_type_autoCreateCart': 'Auto creer panier(XMenu)',
      'terminal_type_autoValidation': 'Auto valider cart(XMenu)',
      'terminal_type_showSuggestions': 'Show Suggestions',
      'terminal_type_displayAmount': 'Show Amount',
      'terminal_type_block_timeout': 'Waiting time',
      'terminal_type_services': 'Services',
      'terminal_type_init_category': 'Init Category',
      'terminal_type_categories': '카테고리',
      'terminal_type_OK': '저장',
    },
    AppLanguge.ja: {
      'terminal_type_title': '設備種類',
      'terminal_type_payments': '支払方法',
      'terminal_type_limit': 'Terminal limit',
      'terminal_type_autoCreateCart': 'Auto creer panier(XMenu)',
      'terminal_type_autoValidation': 'Auto valider cart(XMenu)',
      'terminal_type_showSuggestions': 'Show Suggestions',
      'terminal_type_displayAmount': 'Show Amount',
      'terminal_type_block_timeout': 'Waiting time',
      'terminal_type_services': 'Services',
      'terminal_type_init_category': 'Init Category',
      'terminal_type_categories': 'カテゴリ',
      'terminal_type_OK': '保存',
    },
  };
  @override
  Map<String, Map<String, String>> get keys => _dict;

  @override
  String get name => 'terminal_type';
}
