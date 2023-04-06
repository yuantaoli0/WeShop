import '/models/base.dart';
import 'user.dart';

enum TerminalStatus { none, registered, unregistered, error }

class Terminal extends NetBase {
  static Terminal? currentTerminal;
  List<User> users = [];
  TerminalStatus status = TerminalStatus.none;

  Terminal(json) {
    fromJson(json);
  }

  bool hasPermission(String url) {
    if (this['permissions'] != null) {
      return this['permissions'].indexWhere((element) => element['url'] == url) >= 0;
      //return this['permissions'].indexOf(url) >= 0;
    } else {
      return false;
    }
  }

  @override
  fromJson(json) {
    data = json;
    if (data['users'] != null) {
      for (var itm in data['users']) {
        users.add(User(itm));
      }
    }
  }

  @override
  Future<bool> del() async {
    var res = await delHttp('/terminal/${data['_id']}');
    if (res['status'] == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> reload() async {
    var res = await getHttp('/terminal/${data['_id']}');
    if (res['status'] == 200) {
      fromJson(res['data']);
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> save() async {
    var copy = Map.from(data);
    var res = await putHttp('/terminal', copy);
    if (res['status'] == 200) {
      //data = res['data'];
      return true;
    } else {
      return false;
    }
  }

  Future<Map> getCompanyBySiren(String siren) async {
    var res = await getHttp('/shop/siren/$siren');
    if (res != null && res['status'] == 200) {
      return res['data'];
    } else {
      return {};
    }
  }
}
