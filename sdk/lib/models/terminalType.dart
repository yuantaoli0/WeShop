import 'package:sdk/models/terminal.dart';
import 'package:sdk/util/appInfo.dart';
import 'package:sdk/util/xlogger.dart';
import 'package:sdk/xcontroller.dart';

import 'base.dart';

class TerminalType extends NetBase {
  static TerminalType? currentTerminalType;
  TerminalType(json) {
    data = json;
  }

  Future<TerminalStatus> registerTerminal({String name = ""}) async {
    if (Base.host == '') {
      return TerminalStatus.error;
    }
    try {
      dynamic body;
      if (name == "") {
        body = await postHttp('/shop/registerTerminal', {'appKey': Base.appKey, 'hid': AppInfo.hid});
      } else {
        body = await postHttp('/shop/registerTerminal', {'appKey': Base.appKey, 'hid': AppInfo.hid, 'name': name});
      }
      switch (body["status"]) {
        case 200:
          {
            var json = {};
            if (body["data"]["terminal"] is String) {
              json['_id'] = body["data"]["terminal"];
              json['name'] = name;
              json['blockTimeout'] = body['data']['blockTimeout'];
            } else {
              json = body['data']['terminal'];
              json['blockTimeout'] = body['data']['blockTimeout'];
            }

            if (body["data"]["users"] != null) {
              json['users'] = body['data']['users'];
            }
            if (body["data"]['permissions'] != null) {
              json['permissions'] = body["data"]['permissions'];
            }
            Terminal.currentTerminal = Terminal(json);
            return TerminalStatus.none;
          }
        case 400:
        case 404:
          {
            XController.showMessage(body['msg']);
            return TerminalStatus.unregistered;
          }
        case 500:
        case 505:
          {
            XController.showMessage(body['msg']);
            return TerminalStatus.error;
          }
        default:
          return TerminalStatus.error;
      }
    } catch (err) {
      XController.showMessage(err.toString());
      XLogger.instance.e(err.toString());
      return TerminalStatus.error;
    }
  }

  List<Terminal> terminals = [];
  Future<List<Terminal>> loadTerminals() async {
    var res = await getHttp('/terminalType/${data['_id']}/terminals');
    if (res['status'] == 200) {
      terminals = [];
      for (var itm in res['data']) {
        terminals.add(Terminal(itm));
      }
      return terminals;
    } else {
      return [];
    }
  }

  reload() async {
    var res = await getHttp('/terminalType/${data['_id']}');
    if (res['status'] == 200) {
      data = res['data'];
      return true;
    } else {
      return false;
    }
  }

  del() async {
    var res = await delHttp('/terminalType/${data['_id']}');

    return res;
  }

  save() async {
    var copy = Map.from(data);
    var res = await putHttp('/terminalType', copy);
    if (res['status'] == 200) {
      return true;
    } else {
      return false;
    }
  }
}
