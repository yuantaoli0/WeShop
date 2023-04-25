import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as gt;
import 'package:sdk/util/appInfo.dart';
import 'dart:ui' as ui;

import 'package:sdk/util/jconfig.dart';
import 'package:sdk/util/xlogger.dart';
import 'package:sdk/xcontroller.dart';

abstract class Base {
  static String appKey = '';
  static String host = '';
  static String port = '';
  static String server = '';
  static String token = "";

  Map<dynamic, dynamic> data = Map<dynamic, dynamic>();
  setData(dynamic data) {
    this.data = data;
  }

  clone() {
    return Map.from(data);
  }

  operator [](index) {
    return data[index];
  }

  operator []=(index, value) {
    data[index] = value;
    //data.putIfAbsent(index, () => value);
  }

  Map<dynamic, dynamic> toJson() {
    return data;
  }

  fromJson(json) {
    data = json;
  }

  String get id {
    return data['_id'] ?? '';
  }

  @override
  String toString() {
    return id;
  }
}

abstract class NetBase extends Base {
  Dio dio = Dio(BaseOptions(
    baseUrl: Base.server,
    /*validateStatus: (status) {
        return status == 200 || status == 408 || status == 401;
      }*/
  ));

  static init() async {
    if (Base.host == '') {
      try {
        var config = JConfig();

        Base.host = config['host'] ?? '';
        Base.port = config['port'] ?? '';
        Base.token = config['token'] ?? '';
        if (Base.host != '' && (!Base.host.startsWith('http://') || !Base.host.startsWith('https://'))) {
          Base.host = 'http://' + Base.host;
        }
        Base.server = Base.host + ":" + Base.port;
      } catch (ex) {
        XLogger.instance.e(ex.toString());
      }
    }
  }

  static setServer(String host, String port) async {
    try {
      var dio = Dio();
      var res = await dio.get("http://" + host + ":" + port);

      JConfig config = JConfig();

      config['host'] = host;
      config['port'] = port;
      if (!host.startsWith('http://') || !host.startsWith('https://')) {
        host = 'http://' + host;
      }
      Base.host = host;
      Base.port = port;
      Base.server = host + ":" + port;
      await config.save();
      return true;
    } catch (ex) {
      XController.showMessage(ex.toString());
      return false;
    }
  }

  Future<bool> reload();
  Future<bool> save();
  Future<bool> del();
  bool get isNew {
    return data['_id'] == null;
  }

  Future<String> getShortUniqueCode() async {
    var res = await getHttp('/shop/shortUniqueCode');
    if (res['status'] == 200) {
      return res['data']['code'];
    } else {
      return "";
    }
  }

  _prepareOptions() {
    var options;

    String? version = AppInfo.version;
    String lang = ui.window.locale.languageCode;
    try {
      options = Options(headers: {
        'utoken': (Base.token == "") ? null : Uri.encodeComponent(Base.token),
        'version': Uri.encodeComponent(version ?? ''),
        'language': Uri.encodeComponent(lang),
        "deviceId": Uri.encodeComponent(AppInfo.hid ?? ''),
      });
      return options;
    } catch (ex) {
      options = Options(headers: {
        'utoken': (Base.token == "") ? null : Uri.encodeComponent(Base.token),
        'version': Uri.encodeComponent(version ?? ''),
        'language': Uri.encodeComponent(lang),
      });
      return options;
    }
  }

  getHttp(String url, {bool show400Error = true, bool show500Error = true, bool ingoreSessionTimeout = false}) async {
    var body;
    try {
      if (url.startsWith('http') == false && dio.options.baseUrl.startsWith('http') == false) {
        throw Exception('Url:' + url + ' est incorrect.');
      }
      var response = await dio.get(url, options: _prepareOptions());
      body = response.data;
      if (show400Error && body['status'] >= 400 && body['status'] < 500) {
        XController.showMessage(body['msg']);
      }
      if (show500Error && body['status'] >= 500 && body['status'] < 600) {
        XController.showMessage(body['msg']);
      }
      return body;
    } catch (e) {
      //XController.showMessage(body['msg']);
      var r = exceptionFilter(e, ingoreSessionTimeout: ingoreSessionTimeout);
      if (r != null && r['msg'] != null) {
        XController.showMessage(r['msg']);
      }
      return r;
    }
  }

  delHttp(String url, {bool show400Error = true, bool show500Error = true, bool ingoreSessionTimeout = false}) async {
    try {
      var body;

      var response = await dio.delete(url, options: _prepareOptions());
      body = response.data;

      if (show400Error && body['status'] >= 400 && body['status'] < 500) {
        XController.showMessage(body['msg']);
      }
      if (show500Error && body['status'] >= 500 && body['status'] < 600) {
        XController.showMessage(body['msg']);
      }
      return body;
    } catch (e) {
      var r = exceptionFilter(e, ingoreSessionTimeout: ingoreSessionTimeout);
      if (r != null && r['msg'] != null) {
        XController.showMessage(r['msg']);
      }
      return r;
    }
  }

  Future<dynamic> putHttp(String url, dynamic data, {bool show400Error = true, bool show500Error = true, bool ingoreSessionTimeout = false}) async {
    try {
      var body;

      var response = await dio.put(url, data: data, options: _prepareOptions());
      body = response.data;

      if (show400Error && body['status'] >= 400 && body['status'] < 500) {
        XController.showMessage(body['msg']);
      }
      if (show500Error && body['status'] >= 500 && body['status'] < 600) {
        XController.showMessage(body['msg']);
      }
      return body;
    } catch (e) {
      var r = exceptionFilter(e, ingoreSessionTimeout: ingoreSessionTimeout);
      if (r != null && r['msg'] != null) {
        XController.showMessage(r['msg']);
      }
      return r;
    }
  }

  Future<dynamic> postHttp(String url, dynamic data, {bool show400Error = true, bool show500Error = true, bool ingoreSessionTimeout = false}) async {
    try {
      var body;
      var response = await dio.post(url, data: data, options: _prepareOptions());
      body = response.data;
      if (show400Error && body['status'] >= 400 && body['status'] < 500) {
        XController.showMessage(body['msg']);
      }
      if (show500Error && body['status'] >= 500 && body['status'] < 600) {
        XController.showMessage(body['msg']);
      }
      return body;
    } catch (e) {
      var r = exceptionFilter(e, ingoreSessionTimeout: ingoreSessionTimeout);
      if (r != null && r['msg'] != null) {
        XController.showMessage(r['msg']);
      }
      return r;
    }
  }

  postFile(file, String url, String fileParamName) async {
    Dio dio = new Dio(BaseOptions(
      baseUrl: Base.server,
      //baseUrl: "http://files.weshop.fr:2016",
      /*validateStatus: (status) {
        return status == 200 || status == 408 || status == 401;
      }*/
    ));
    try {
      FormData? formData;
      if (file is String) {
        formData = FormData.fromMap({fileParamName: MultipartFile.fromFileSync(file)});
      } else if (file is File) {
        formData = FormData.fromMap({fileParamName: MultipartFile.fromFileSync(file.path)});
      }
      var response = await dio.post(url, data: formData, options: _prepareOptions());

      return response.data;
    } catch (ex, stack) {
      var r = exceptionFilter(ex);
      if (r != null && r['msg'] != null) {
        XController.showMessage(r['msg']);
      }
      return r;
    }
  }

    postimage(file, String url, String avatarImage) async {
    Dio dio = new Dio(BaseOptions(
      baseUrl: Base.server,
      //baseUrl: "http://files.weshop.fr:2016",
      /*validateStatus: (status) {
        return status == 200 || status == 408 || status == 401;
      }*/
    ));
    try {
      FormData? formData;
      if (file is String) {
        formData =
            FormData.fromMap({avatarImage: MultipartFile.fromFileSync(file)});
      } else if (file is File) {
        formData = FormData.fromMap(
            {avatarImage: MultipartFile.fromFileSync(file.path)});
      }
      var response =
          await dio.post(url, data: formData, options: _prepareOptions());

      return response.data;
    } catch (ex, stack) {
      var r = exceptionFilter(ex);
      if (r != null && r['msg'] != null) {
        XController.showMessage(r['msg']);
      }
      return r;
    }
  }

  exceptionFilter(err, {bool ingoreSessionTimeout = false}) {
    if (err is DioError && err.response != null) {
      switch (err.response?.statusCode) {
        case 401:
        case 408:
          if (ingoreSessionTimeout == false && gt.Get.currentRoute != '/login') {
            gt.Get.toNamed('/login');
          }
          break;
        //return XAuthException(err.response.data["msg"]);
        case 503:
          return {'status': 503, 'msg': err.response?.data["msg"]};
        //XPaymentException(err.response.data["msg"]);
        default:
          return {'status': 500, 'msg': err.toString()};
      }
    } else if (err is SocketException) {
      XLogger().e(err.message);
      return {'status': 405, 'msg': 'Server indisponible.'};
    } else {
      if (err.error != null && err.error.message != null) {
        XLogger().e(err.error.message ?? '');
        return {'status': 499, 'msg': 'Reseau indisponible'};
      } else {
        XLogger().e(err.toString());
        return {'status': 499, 'msg': 'Reseau indisponible' + err.toString()};
      }
    }
  }
}

class XAuthException implements Exception {
  String? _msg;
  String? get msg => _msg;
  XAuthException(msg) {
    _msg = msg;
  }
}

class XPaymentException implements Exception {
  String? _msg;
  String? get msg => _msg;
  XPaymentException(msg) {
    _msg = msg;
  }
}
