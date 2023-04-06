import 'package:dio/dio.dart';
import 'package:sdk/models/department.dart';
import 'package:sdk/models/employe.dart';
import 'package:sdk/models/post.dart';
import 'base.dart';
import 'terminal.dart';
import 'terminalType.dart';
import 'user.dart';

class Shop extends NetBase {
  static final Shop instance = Shop._internal();
  bool isBaseOnWithTax = true;
  bool canHaveProof = false;
  bool canHaveInvoice = false;
  bool isExpired = false;
  Map? shopInfo;

  factory Shop() {
    return instance;
  }

  Shop._internal();

  @override
  Future<bool> del() async {
    throw UnimplementedError();
  }

  @override
  Future<bool> reload() async {
    // TODO: implement reload
    throw UnimplementedError();
  }

  @override
  Future<bool> save() async {
    // TODO: implement save
    throw UnimplementedError();
  }

  Future<dynamic> getShopInformation() async {
    var body = await getHttp('/shop/information');
    if (body["status"] == 200) {
      if (body['data']['shop'] != null) {
        isExpired = body['data']['shop']['isExpired'];
        shopInfo = body['data']['shop'];
      }
      return body["data"];
    } else {
      return null;
    }
  }

  List<User> users = [];
  List<dynamic> functions = [];
  loadFunctions() async {
    var res = await getHttp('/shop/functions');
    if (res['status'] == 200) {
      functions = res['data']["functions"];
      return functions;
    }
  }

  Future<List<User>> loadAccounts() async {
    var res = await getHttp('/shop/users');
    if (res['status'] == 200) {
      users.clear();
      for (var u in res['data']) {
        users.add(User(u));
      }
      return users;
    } else {
      return [];
    }
  }

  Future<List<Employe>> loadEmployes() async {
    var res = await getHttp('/shop/employes');
    if (res['status'] == 200) {
      List<Employe> employes = [];
      for (var ep in res['data']["employes"]) {
        employes.add(Employe(ep));
      }
      return employes;
    } else {
      return [];
    }
  }

  Future<List<Department>> loadDartpements() async {
    var res = await getHttp('/shop/departments');
    if (res['status'] == 200) {
      List<Department> departments = [];
      for (var d in res['data']["departments"]) {
        departments.add(Department(d));
      }
      return departments;
    } else {
      return [];
    }
  }

  List<TerminalType> terminalTypes = [];
  Future<List<TerminalType>> loadTerminalTypes() async {
    var res = await getHttp('/shop/terminalTypes');
    if (res['status'] == 200) {
      terminalTypes.clear();
      for (var itm in res['data']) {
        terminalTypes.add(TerminalType(itm));
      }
      return terminalTypes;
    } else {
      return [];
    }
  }

  Future<bool> startup(data) async {
    var res = await postHttp('/shop/startup', data);
    if (res['status'] == 200) {
      List<User> users = [];
      for (var u in res["data"]["users"]) {
        users.add(User(u));
      }
      Terminal.currentTerminal?.users = users;
      return true;
    } else {
      return false;
    }
  }

  Future<bool> postLisence(license) async {
    license.remove("endDate");
    license.remove("startDate");
    var body = await postHttp('/shop/license', license);
    if (body['status'] == 200) {
      return true;
    } else {
      return false;
    }
  }
}
