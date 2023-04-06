import 'package:get/get.dart';
import 'package:sdk/models/terminalType.dart';
import 'package:sdk/xcontroller.dart';

class UserTerminalTypesController extends XController {
  RxList<TerminalType> rxTerminalTypes = RxList([]);
  RxList rxSelectedTypes = RxList([]);
  UserTerminalTypesController(this.rxTerminalTypes, List selected) {
    rxSelectedTypes.addAll(selected);
  }

  selectTyperminalType(TerminalType terminalType) {
    for (var idx = 0; idx < rxSelectedTypes.length; idx++) {
      var itm = rxSelectedTypes[idx];
      if (itm == terminalType['_id']) {
        rxSelectedTypes.remove(itm);
        rxTerminalTypes.refresh();
        return;
      }
    }
    rxSelectedTypes.add(terminalType['_id']);
    rxTerminalTypes.refresh();
  }

  @override
  accept() {
    close(rxSelectedTypes);
  }
}
