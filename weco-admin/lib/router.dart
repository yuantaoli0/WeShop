import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/router.dart';
import 'package:weco_admin/home/view.dart';
import 'app.dart';
import 'job/router.dart';
import 'home/router.dart';
import 'contract/router.dart';
import 'department/router.dart';
import './schedule/router.dart';

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
      case '/jobmanagement':
        return JobManagementRouter().pageRoute(settings);
      case '/contractmanagement':
        return ContractRouter().pageRoute(settings);
      case '/department':
        return DapartmentRouter().pageRoute(settings);
      case '/schedule':
        return ScheduleRouter().pageRoute(settings);
      default:
        return XDKRouter.onGenerateRoute(settings);
    }
  }
}
