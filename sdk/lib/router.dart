import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sdk/views/about/router.dart';
import 'package:sdk/views/admin/accounts/user/router.dart';
import 'package:sdk/views/admin/departments/department/router.dart';
import 'package:sdk/views/admin/departments/router.dart';
import 'package:sdk/views/admin/employes/employe/router.dart';
import 'package:sdk/views/admin/employes/router.dart';
import 'package:sdk/views/admin/terminalTypes/terminal_type/router.dart';
import 'package:sdk/views/first_start/router.dart';
import 'package:sdk/views/login/router.dart';
import 'package:sdk/views/terminal_register/router.dart';

import 'views/admin/accounts/router.dart';
import 'views/admin/terminalTypes/router.dart';
import 'views/server_config/router.dart';

abstract class XBaseRouter {
  String? name;
  GetView? page;
  ModalRoute pageRoute(RouteSettings settings);
  dialog(dynamic args);

  Future<dynamic> gotoName(String name, {args, isDialog = true}) async {
    if (isPhone) {
      return await Get.toNamed(name, arguments: args, preventDuplicates: false);
    } else {
      if (isDialog == true) {
        return await dialog(args);
      } else {
        return await Get.toNamed(name, arguments: args, preventDuplicates: false);
      }
    }
  }

  bool get isPhone {
    MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);

    return data.size.shortestSide < 550;
  }

  offName(String name, {args}) async {
    if (isPhone) {
      return await Get.offNamed(name, arguments: args);
    } else {
      return await dialog(args);
    }
  }

  offAllName(String name, {args}) async {
    if (isPhone) {
      return await Get.offAllNamed(name, arguments: args);
    } else {
      return await dialog(args);
    }
  }

  offAndToName(String name, args) async {
    if (isPhone) {
      return await Get.offAndToNamed(name, arguments: args);
    } else {
      return await dialog(args);
    }
  }

  double dialogWidth() {
    return 400.w;
  }
}

class XDKRouter {
  static String checkUrl(String url) {
    var tmp = '';
    if (url.contains('_')) {
      for (var idx = 0; idx < url.length; idx++) {
        var ch = url[idx];
        if (ch == '_') {
          idx++;
          ch = url[idx];
          tmp += ch.toUpperCase();
          //idx++;
        } else {
          tmp += ch;
        }
      }
      return tmp;
    } else {
      return url;
    }
  }

  static Route onGenerateRoute(RouteSettings settings) {
    //Map arguments = settings.arguments as Map;
    var url = checkUrl(settings.name!);

    switch (url) {
      case '/serverConfig':
        //return GetPageRoute();
        return ServerConfigRouter().pageRoute(settings);
      case '/terminalRegister':
        return TerminalRegisterRouter().pageRoute(settings);
      case '/firstStart':
        return FirstStartRouter().pageRoute(settings);
      case '/employes':
        return EmployeManagerRouter().pageRoute(settings);
      case '/employe':
        return EmployeRouter().pageRoute(settings);
      case '/departments':
        return DepartmentManagerRouter().pageRoute(settings);
      case '/department':
        return DepartmentRouter().pageRoute(settings);
      case '/login':
        return LoginRouter().pageRoute(settings);
      case '/accounts':
        return AccountManagerRouter().pageRoute(settings);
      case '/account':
        return AccountRouter().pageRoute(settings);
      case '/terminals':
        return TerminalTypeManagerRouter().pageRoute(settings);
      case '/about':
        return AboutRouter().pageRoute(settings);
      default:
        var args = settings.arguments as Map;
        return GetPageRoute(
          settings: settings,
          transition: Transition.fade,
          page: () => Scaffold(
            appBar: AppBar(),
            drawer: args['systemMenu'],
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
