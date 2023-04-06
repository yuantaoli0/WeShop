import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sdk/models/shop.dart';
import 'package:sdk/models/terminal.dart';
import 'package:sdk/models/user.dart';
import 'package:sdk/xcontroller.dart';

class LoginController extends XController {
  Rx<User?> rxSelectedUser = Rx(null);
  RxList<User> rxUsers = RxList([]);
  var isLoading = false.obs;
  TextEditingController? passwordController;
  FocusNode? passwordFocus;
  String? pushToken;
  LoginController(this.pushToken);

  doLogin() async {
    /*Dio dio = new Dio();
    var res = await dio.get("http://192.168.1.103/simple-list.html");

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => await Printing.convertHtml(
              format: format,
              html: res.data,
              //baseUrl: "http://192.168.1.103/1.html",
            ));*/
    if (rxSelectedUser.value != null) {
      isLoading.value = true;
      var r = await rxSelectedUser.value?.doLogin(passwordController!.text, pushToken: pushToken);
      isLoading.value = false;
      if (r == true) {
        var shopInfo = Shop().shopInfo;
        if (shopInfo?['endDate'] != null) {
          try {
            var end = DateTime.parse(shopInfo!['endDate']!.toString()).toLocal();
            var days = end.difference(DateTime.now()).inDays;
            if (days <= 15) {
              var content = '';
              if (days > 0) {
                content = 'La license vas expirer dans ${days}jours';
              } else {
                content = 'La license est deja expirer.';
              }
              await XController.showMessage(content, isDialog: true);
            }
          } catch (ex) {}
        }
        passwordController!.clear();
        close(true);
      }
    }
  }

  selectUser(User? u) {
    rxSelectedUser.value = u;
    XController.requestFocus(passwordFocus!);
  }

  @override
  void onInit() {
    List<User> list = [];
    User u;
    if (Terminal.currentTerminal?.users != null) {
      for (var itm in Terminal.currentTerminal!.users) {
        u = itm;
        if (Terminal.currentTerminal!['lastUser'] == u['_id']) {
          rxSelectedUser.value = u;
        }
        list.add(u);
      }
    }
    rxUsers.assignAll(list.obs);
    passwordController = TextEditingController();
    passwordFocus = FocusNode();
    super.onInit();
  }
}
