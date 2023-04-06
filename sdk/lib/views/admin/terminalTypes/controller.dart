import 'package:sdk/models/shop.dart';
import 'package:sdk/models/terminal.dart';
import 'package:sdk/models/terminalType.dart';
import 'package:sdk/xcontroller.dart';
import 'package:get/get.dart';

import 'terminal/router.dart';
import 'terminal_type/router.dart';

class TerminalTypeManagerController extends XController {
  var isLoading = false.obs;
  RxList<TerminalType> rxTerminalTypes = RxList([]);
  RxList<Terminal> rxTerminals = RxList([]);

  RxInt rxCurrentTabIndex = 0.obs;
  @override
  void onInit() {
    isLoading.value = false;

    Shop().loadTerminalTypes().then((types) {
      rxTerminalTypes.addAll(types);
      isLoading.value = false;
      changeTab(0);
    }).catchError((_) {
      isLoading.value = false;
    });

    super.onInit();
  }

  changeTab(int idx) {
    rxCurrentTabIndex.value = idx;
    isLoading.value = true;
    rxTerminalTypes[idx].loadTerminals().then((terminals) {
      rxTerminals.clear();
      rxTerminals.addAll(terminals);
      isLoading.value = false;
    }).catchError((_) {
      isLoading.value = false;
    });
  }

  openTerminal(Terminal terminal) async {
    var r = await TerminalRouter().gotoName('/terminal', args: {'terminal': terminal});
    if (r == true) {
      rxTerminals.refresh();
    }
    if (r == false) {
      rxTerminals.remove(terminal);
    }
  }

  openTerminalTypeConfig() async {
    await TerminalTypeRouter().gotoName('/terminalType', args: {'terminalType': rxTerminalTypes[rxCurrentTabIndex.value]});
  }
}
