import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/router.dart';
import 'package:weco_admin/home/view.dart';
import 'app.dart';
import 'departments/department/router.dart';
import 'home/router.dart';
import 'contract/router.dart';
import 'departments/router.dart';
import './employes/router.dart';
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
      case '/department':
        return DepartmentRouter().pageRoute(settings);
      case '/contractmanagement':
        return ContractRouter().pageRoute(settings);
      case '/departments':
        return DepartmentsRouter().pageRoute(settings);
      case '/employes':
        return EmployesRouter().pageRoute(settings);
      case '/schedule':
        return ScheduleRouter().pageRoute(settings);
      default:
        return XDKRouter.onGenerateRoute(settings);
    }
  }
}
