import 'package:sdk/models/department.dart';
import 'package:sdk/xcontroller.dart';

import 'base.dart';

class Post extends NetBase {
  Department department;

  Post(json, this.department) {
    fromJson(json);
  }

  @override
  Future<bool> del() async {
    var res = await delHttp('/post/${data['_id']}');

    if (res['status'] == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> reload() async {
    if (isNew) {
      var res = await getHttp('/post/${data['_id']}');

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
      var res = await postHttp('/department/${department.id}/newPost', copy);
      if (res['status'] == 200) {
        fromJson(res['data']);
        return true;
      } else {
        return false;
      }
    } else {
      var res = await putHttp('/post', copy);
      if (res['status'] == 200) {
        return true;
      } else {
        return false;
      }
    }
  }
}
