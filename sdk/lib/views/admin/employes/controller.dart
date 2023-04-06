import 'package:get/get.dart';
import 'package:sdk/models/employe.dart';
import 'package:sdk/models/shop.dart';
import 'package:sdk/views/admin/employes/employe/router.dart';
import 'package:sdk/xcontroller.dart';

class EmployeManagerController extends XController {
  RxList<Employe> rxEmployes = RxList([]);
  RxBool rxIsloading = false.obs;

  EmployeManagerController() {
    loadEmployes();
  }

  loadEmployes() {
    rxIsloading.value = true;
    rxEmployes.clear();
    Shop().loadEmployes().then((employes) {
      rxEmployes.addAll(employes);
      rxIsloading.value = false;
    }).catchError((e) {
      rxIsloading.value = false;
    });
  }

  newEmploye() {
    Employe ep = Employe({'active': true, 'shop': Shop().id});
    EmployeRouter().gotoName('/employe', args: {'employe': ep}).then((value) {
      loadEmployes();
    });
  }

  openEmploye(Employe ep) {
    EmployeRouter().gotoName('/employe', args: {'employe': ep}).then((value) {
      loadEmployes();
    });
  }
}
