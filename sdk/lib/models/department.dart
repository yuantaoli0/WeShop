import 'package:sdk/xcontroller.dart';

import 'base.dart';
import 'post.dart';

class Department extends NetBase {
  Department(json) {
    fromJson(json);
  }

  Future<List<Post>> loadPosts() async {
    var res = await getHttp('/department/$id/posts');
    if (res['status'] == 200) {
      List<Post> posts = [];
      for (var ep in res['data']["posts"]) {
        posts.add(Post(ep, this));
      }
      return posts;
    } else {
      return [];
    }
  }


  Future<List<Post>> loadPosts_2(String? departmentId) async {
    var res = await getHttp('/department/$departmentId/posts');
    if (res['status'] == 200) {
      List<Post> posts = [];
      for (var ep in res['data']["posts"]) {
        posts.add(Post(ep, this));
      }
      return posts;
    } else {
      return [];
    }
  }


  newPost(data) async {
    data['department'] = id;
    var res = await postHttp('/department/$id/newPost', data);
    if (res['status'] == 200) {
      return true;
    }
  }

  @override
  Future<bool> del() async {
    var res = await delHttp('/department/${data['_id']}');
    if (res['status'] == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> reload() async {
    if (isNew) {
      var res = await getHttp('/department/${data['_id']}');

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
      var res = await postHttp('/shop/newDepartment', copy);
      if (res['status'] == 200) {
        fromJson(res['data']);
        return true;
      } else {
        return false;
      }
    } else {
      var res = await putHttp('/department', copy);
      if (res['status'] == 200) {
        return true;
      } else {
        return false;
      }
    }
  }
}
