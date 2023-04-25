import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sdk/xView.dart';
import 'package:weco_admin/home/controller.dart';
import 'employescontroller.dart';

import '../departments/department/view.dart';
import '../system_menu/menu_view.dart';
import '../theme.dart';

class EmployeView extends XView<EmployesController> {
  EmployeView(args, EmployesController controller) : super(args, controller);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
          child: Row(
        children: [
          Expanded(child: SideMenu()),
          Expanded(flex: 5, child: Center(child: Text('Employes')))
        ],
      )),
    );
  }
}
