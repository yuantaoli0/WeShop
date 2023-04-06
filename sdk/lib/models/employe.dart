import 'package:sdk/xcontroller.dart';

import 'base.dart';

class Employe extends NetBase {
  Employe(json) {
    fromJson(json);
  }
  @override
  Future<bool> del() async {
    var res = await delHttp('/employe/${data['_id']}');

    if (res['status'] == 200) {
      return true;
    } else {
      return false;
    }
  }

  DateTime? get birthday {
    return this['birthday'] == null
        ? null
        : this['birthday'] is DateTime
            ? this['birthday']
            : DateTime.parse(this['birthday']).toLocal();
  }

  set birthday(DateTime? dt) {
    this['birthday'] = dt?.toIso8601String();
  }

  @override
  Future<bool> reload() async {
    if (isNew) {
      var res = await getHttp('/employe/${data['_id']}');

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
    if (isNew) {
      var res = await postHttp('/shop/newEmploye', copy);
      if (res['status'] == 200) {
        fromJson(res['data']);
        return true;
      } else {
        return false;
      }
    } else {
      var res = await putHttp('/employe', copy);
      if (res['status'] == 200) {
        return true;
      } else {
        return false;
      }
    }
  }
}
