import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sdk/models/user.dart';
import 'models/base.dart';
import 'models/terminal.dart';
import 'models/terminalType.dart';

import 'persmission.dart';
import 'util/appInfo.dart';
import 'util/jconfig.dart';
import 'util/xpath.dart';
import 'views/about/permissions.dart';
import 'views/admin/accounts/permissions.dart';
import 'views/admin/terminalTypes/permissions.dart';
import 'views/first_start/router.dart';
import 'xcontroller.dart';

class SDKController extends XController {
  var semantic = "".obs;
  static List<XPermission> permissions = [];

  addPermission(XPermission permission) {
    if (permission.isPermission) {
      permissions.add(permission);
    }
  }

  Future<dynamic> initService(String appkey, {String? pushToken, String? login, String? passwd}) async {
    semantic.value = 'Lecture de configuration';
    await AppInfo.init();
    await XPath.init();
    await JConfig.init();
    Base.appKey = appkey;
    await NetBase.init();
    //var reader = NFCReader.instance;
    //XLogger().e('starting');
    if (Base.host == '') {
      semantic.value = 'Configuration de serveur';

      var r = await Get.toNamed('/serverConfig');
      if (r != true) {
        //如果服务器没有添加成功,退出APP
        SystemNavigator.pop();
        return false;
      }
    }
    semantic.value = 'Enregistre terminal';
    //创建设备类型,准备注册当前设备
    TerminalType.currentTerminalType = TerminalType({'appkey': appkey, 'active': true, 'version': AppInfo.version});
    var status = await TerminalType.currentTerminalType?.registerTerminal(); //询问当前设备是否已经注册过
    var r;
    if (status == TerminalStatus.none) {
      if (Terminal.currentTerminal?.users == null || Terminal.currentTerminal?.users.isEmpty == true) {
        semantic.value = 'Configuration de système';
        r = await FirstStartRouter().gotoName('/firstStart');
      } else {
        r = true;
      }
      if (r == true) {
        semantic.value = 'Connexion de compte';
        _initPermissions();
        r = false;
        if (Base.token != '') {
          User user = User({});
          r = await user.loginWithToken(Base.token);
        }
        if (r != true) {
          if (login != null && passwd != null) {
            User user = User({'login': login});
            r = await user.doLogin(passwd);
            r ??= false;
          } else {
            r = false;
          }
        }
        if (r == false) {
          return await Get.toNamed('/login', arguments: {'pushToken': pushToken});
        } else {
          return r;
        }
        //return await Get.toNamed('/login', arguments: {'pushToken': pushToken});
      }
    } else if (status == TerminalStatus.registered) {
      semantic.value = '';
      XController.showMessage('Le terminal est deja existe');
    } else if (status == TerminalStatus.unregistered) {
      //如果设备还未注册,则跳转到设备注册页面
      r = await Get.toNamed('/terminalRegister');
      if (r == true) {
        if (Terminal.currentTerminal?.users == null || Terminal.currentTerminal?.users.isEmpty == true) {
          semantic.value = 'Configuration de système';
          r = await FirstStartRouter().gotoName('/firstStart');
        } else {
          r = true;
        }
        if (r == true) {
          _initPermissions();
          semantic.value = 'Connexion de compte';
          if (Base.token != '') {
            User user = User({});
            r = await user.loginWithToken(Base.token);
          } else if (login != null && passwd != null) {
            User user = User({'login': login});
            r = await user.doLogin(passwd);
            r ??= false;
          } else {
            r = false;
          }
          if (r == false) {
            return await Get.toNamed('/login', arguments: {'pushToken': pushToken});
          } else {
            return r;
          }
        }
      } else {
        //如果没有注册成功,退出APP
        semantic.value = 'Erreur de connexion avec serveur';
      }
    } else if (status == TerminalStatus.error) {
      semantic.value = 'Erreur de connexion avec serveur';
      var r = await Get.toNamed('/serverConfig');
      if (r != true) {
        return false;
      } else {
        return await initService(appkey);
      }
    }
    semantic.value = '';
    return false;
  }

  _initPermissions() {
    addPermission(AboutsPermission(-1));
    addPermission(TerminalTypesPermission(1));
    addPermission(AccountsPermission(2));
    /*addPermission(WorkingPermission(1));
    addPermission(CartPermission(2));
    addPermission(CheckOrderPermission(3));
    addPermission(PeriodPermission(4));
    addPermission(CategoriesPermission(5));
    addPermission(SuppliersPermission(5.5));
    addPermission(CustomersPermission(6));
    addPermission(LogsPermission(7));
    addPermission(DevicesPermission(8));
    addPermission(ReturnOrderPermission(9));
    addPermission(DepositsPermission(10));
    addPermission(CardTypesPermission(11));
    addPermission(CouponsPermission(12));
    addPermission(DiscountsPermission(13));
    addPermission(BundlesPermission(14));
    
    addPermission(ServicesPermission(16));
    addPermission(TicketMessagesPermission(17));
    addPermission(PaymentsPermission(18));
    addPermission(TaxesPermission(19));
    addPermission(TagsPermission(24));
    
    
    addPermission(TodayOrdersPermission(22));
    addPermission(GiftsPermission(23));*/
  }
}
