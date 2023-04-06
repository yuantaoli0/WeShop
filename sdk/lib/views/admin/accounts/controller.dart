import 'package:get/get.dart';
import 'package:sdk/models/shop.dart';
import 'package:sdk/models/user.dart';
import 'package:sdk/xcontroller.dart';

import 'user/router.dart';

class AccountManagerController extends XController {
  RxList<User> rxUsers = RxList<User>();
  //RxList rxFunctions = RxList([]);
  var isLoading = false.obs;

  @override
  void onInit() {
    isLoading.value = true;
    Shop().loadAccounts().then((users) {
      rxUsers.clear();
      rxUsers.addAll(users);
      isLoading.value = false;
    });
    /*Shop().loadFunctions().then((functions) {
      this.rxFunctions.addAll(functions);
    });*/
    super.onInit();
  }

  openAccount(User u) async {
    var r = await AccountRouter().gotoName('/account', args: {'user': u});
    if (r == false) {
      rxUsers.remove(u);
    } else {
      rxUsers.refresh();
    }
  }

  cloneAccount(User user) async {
    User newUser = user.clone();
    var r = await AccountRouter().gotoName('/account', args: {'user': newUser});
    if (r == true) {
      rxUsers.add(newUser);
    }
  }

  newAccount() async {
    User u = User({'active': true, 'functions': []});
    var r = await AccountRouter().gotoName('/account', args: {'user': u});
    if (r == true) {
      rxUsers.add(u);
    }
  }
}
