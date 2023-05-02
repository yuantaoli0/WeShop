import 'package:sdk/xcontroller.dart';

import 'base.dart';
import 'post.dart';

class Contract extends NetBase {
  Contract(json) {
    fromJson(json);
  }

  @override
  Future<bool> del() async {
    var res = await delHttp('/contract/${data['_id']}');
    if (res['status'] == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> reload() async {
    if (isNew) {
      var res = await getHttp('/contract/${data['_id']}');

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
      var res = await postHttp('/shop/newContract', copy);
      if (res['status'] == 200) {
        fromJson(res['data']);
        return true;
      } else {
        return false;
      }
    } else {
      var res = await putHttp('/contract', copy);
      if (res['status'] == 200) {
        return true;
      } else {
        return false;
      }
    }
  }

  // Future<List<Contract>> loadContracts() async {
  //   var res = await getHttp('/shop/contracts');
  //   if (res['status'] == 200) {
  //     List<Contract> contracts = [];
  //     for (var cs in res['data']["contracts"]) {
  //       contracts.add(Contract(cs));
  //     }
  //     return contracts;
  //   } else {
  //     return [];
  //   }
  // }
}
