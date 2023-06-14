import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/router.dart';
import 'package:weco_admin/work/router.dart';
import 'app.dart';
import 'home/router.dart';
import 'option/router.dart';

class XRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return GetPageRoute(
          settings: settings,
          transition: Transition.fade,
          page: () => AppView(settings.arguments),
        );
      case '/home':
        return HomeRouter().pageRoute(settings);
      case '/option':
        return OptionRouter().pageRoute(settings);
      case '/work':
        return WorkRouter().pageRoute(settings);
      default:
        return XDKRouter.onGenerateRoute(settings);
    }
  }
}
