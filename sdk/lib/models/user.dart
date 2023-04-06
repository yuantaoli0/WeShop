import 'package:sdk/models/employe.dart';
import 'package:sdk/models/terminal.dart';
import 'package:sdk/util/jconfig.dart';
import 'package:sdk/util/xlogger.dart';
import 'package:sdk/views/appUpdater/router.dart';
import 'package:sdk/xcontroller.dart';

import 'base.dart';
import 'shop.dart';

class User extends NetBase {
  static User? currentUser;
  List<Map<String, Object>> permissions = [];

  User(json) {
    fromJson(json);
  }

  Future<bool> postPushToken(String token) async {
    var res = await postHttp('/user/${Terminal.currentTerminal?.id}/pushToken', {'pushToken': token});
    return res['status'] == 200;
  }

  requestPermission(String url, String name, {String? login, String? passwd, String? cardNumber}) async {
    if (this['isRoot'] == true) {
      return true;
    } else {
      var r = await postHttp('/user/${Terminal.currentTerminal!.id}/requestPermission', {
        "permission": {"name": name, "url": url},
        "user": {"login": login, "passwd": passwd, "cardNumber": cardNumber},
      });
      return r['status'] == 200 && r['data']['permission'] == true;
    }
  }

  canAccess(String route) {
    if (this['isRoot'] == true) {
      return true;
    } else {
      return permissions.indexWhere(
              (p) => p['url'] == route && p['canAccess'] == true && (p['terminalType'] == null || p['terminalType'] == Terminal.currentTerminal?['type'])) >=
          0;
    }
  }

  hasPermission(String route) {
    if (this['isRoot'] == true) {
      return true;
    } else {
      return permissions.indexWhere((p) => p['url'] == route && (p['terminalType'] == null || p['terminalType'] == Terminal.currentTerminal?['type'])) >= 0;
    }
  }

  String? get homeUrl {
    for (var p in permissions) {
      if (p['isDefault'] == true) {
        return '/${p['url']}';
      }
    }
    return null;
  }

  @override
  Future<bool> del() async {
    var res = await delHttp('/user/${data['_id']}');

    if (res['status'] == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> reload() async {
    if (isNew) {
      var res = await getHttp('/user/${data['_id']}');

      if (res['status'] == 200) {
        fromJson(res['data']['document']);
        return true;
      } else {
        XController.showMessage(res['msg']);
        return false;
      }
    } else {
      return true;
    }
  }

  @override
  Future<bool> save() async {
    var copy = Map.from(data);
    copy['permissions'] = permissions;
    if (this.isNew) {
      var res = await postHttp('/shop/newUser', copy);
      if (res['status'] == 200) {
        fromJson(res['data']);
        return true;
      } else {
        return false;
      }
    } else {
      var res = await putHttp('/user', copy);
      if (res['status'] == 200) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  fromJson(json) {
    if (json['permissions'] != null) {
      for (var itm in json['permissions']) {
        permissions.add(itm);
      }
    } else {
      permissions = [];
    }
    return super.fromJson(json);
  }

  Future<String?> getCode4OneTimePassword() async {
    var r = await getHttp('/user/code4OneTimePassword');
    if (r['status'] == 200) {
      return r['data'];
    } else {
      return null;
    }
  }

  Future<Map?> checkOneTimePassword(code) async {
    var r = await getHttp('/user/checkOneTimePassword?code=$code');
    if (r['status'] == 200) {
      return r['data'];
    } else {
      return null;
    }
  }

  Future<bool> loginWithToken(String token, {String? pushToken}) async {
    try {
      var res = await postHttp('/user/${Terminal.currentTerminal?.id}/loginWithToken', {'token': token, 'pushToken': pushToken}, ingoreSessionTimeout: true);
      if (res['status'] == 200) {
        fromJson(res['data']);
        data['token'] = token;
        currentUser = this;
        await Shop().getShopInformation();
        return true;
      } else if (res['status'] == 501) {
        var r = await AppUpdaterRouter().gotoName('/appUpdater', args: {
          'newVersion': res['data']['newVersion'],
          'msg': res['msg'],
          'url': res['data']['url'],
        });
        return false;
      }
      JConfig config = JConfig();

      config['token'] = '';
      await config.save();
      return false;
    } catch (err) {
      JConfig config = JConfig();

      config['token'] = '';
      await config.save();
      return false;
      //msg = err.toString();
    }
  }

  doLogin(String passwd, {String? pushToken}) async {
    try {
      var res = await postHttp('/user/${Terminal.currentTerminal?.id}/login', {'login': this['login'], 'passwd': passwd, 'pushToken': pushToken},
          ingoreSessionTimeout: true);
      if (res['status'] == 200) {
        Base.token = res["data"]["utoken"];
        JConfig config = new JConfig();

        config['token'] = Base.token;
        await config.save();
        fromJson(res['data']);
        data['passwd'] = passwd;
        currentUser = this;
        await Shop().getShopInformation();
        return true;
      } else if (res['status'] == 501) {
        var r = await AppUpdaterRouter().gotoName('/appUpdater', args: {
          'newVersion': res['data']['newVersion'],
          'msg': res['msg'],
          'url': res['data']['url'],
        });
        return false;
      }
    } catch (err, stack) {
      XLogger().e('$err\n$stack');
      XController.showMessage(err.toString());
      //msg = err.toString();
    }
  }

  doLogout() async {
    try {
      var body = await postHttp('/user/logout', {});
      if (body['status'] == 200) {
        Base.token = body["utoken"];
        JConfig config = new JConfig();

        config['token'] = '';
        await config.save();
        return true;
      } else {
        return false;
      }
    } on Exception catch (err) {
      return false;
    }
  }
}
