import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      "app_about": "about",
      "app_periods": "Periods",
      "app_shop": "Shop",
      "app_departments": "Departments",
      "app_employes": "Employes",
      "app_accounts": "Account",
      "app_terminals": "Terminals",
      "app_logout_confirm": "Confirm",
      "app_logout_confimContent": "Are you sur to logout?",
    },
    AppLanguge.fr: {
      "app_about": "A propos de",
      "app_periods": "Périodes",
      "app_shop": "Magasin",
      "app_departments": "Departments",
      "app_employes": "Employes",
      "app_accounts": "Comptes",
      "app_terminals": "Terminaux",
      "app_logout_confirm": "Confirmation",
      "app_logout_confimContent": "Vous etes sur de quitter?",
    },
    AppLanguge.zh: {
      "app_about": "关于",
      "app_periods": "时段",
      "app_departments": "部门",
      "app_employes": "员工",
      "app_accounts": "账号",
      "app_terminals": "终端",
      "app_logout_confirm": "确认",
      "app_logout_confimContent": "您确认要退出吗?",
    },
    AppLanguge.ko: {
      "app_about": "...에 관하여",
      "app_periods": " 기간",
      "app_shop": " 숍",
      "app_departments": "Departments",
      "app_employes": "Employes",
      "app_accounts": " 아이디",
      "app_terminals": " 터미널",
      "app_logout_confirm": " 확인",
      "app_logout_confimContent": "로그아웃 하시겠습니까?",
    },
    AppLanguge.ja: {
      "app_about": "about",
      "app_periods": "Periods",
      "app_shop": "Shop",
      "app_departments": "Departments",
      "app_employes": "Employes",
      "app_accounts": "Account",
      "app_terminals": "Terminals",
      "app_logout_confirm": "Confirm",
      "app_logout_confimContent": "Are you sur to logout?",
    }
  };
  @override
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => 'app_';
}
