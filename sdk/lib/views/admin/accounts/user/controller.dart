import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/language.dart';
import 'package:sdk/models/employe.dart';
import 'package:sdk/models/shop.dart';
import 'package:sdk/models/terminal.dart';
import 'package:sdk/models/terminalType.dart';
import 'package:sdk/models/user.dart';
import 'package:sdk/persmission.dart';
import 'package:sdk/sdkController.dart';
import 'package:sdk/util/nfc_reader.dart';
import 'package:sdk/xcontroller.dart';

import 'user_terminal_types/router.dart';

class AccountControler extends XController {
  Rx<User?> rxUser = Rx(null);
  Rx<Employe?> rxSelectedEmploye = Rx(null);
  RxList<Employe> rxEmployes = RxList([]);
  RxList<TerminalType> rxTerminalTypes = RxList([]);
  RxList<XPermission> rxPermissions = RxList();
  TextEditingController loginController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();

  FocusNode loginFocuse = FocusNode();
  FocusNode passwdFocuse = FocusNode();
  FocusNode nameFocuse = FocusNode();
  FocusNode telephoneFocuse = FocusNode();
  FocusNode cardNumberFocuse = FocusNode();

  var isSaving = false.obs;
  var formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    loginController.text = rxUser.value!['login'] ?? '';
    passwdController.text = rxUser.value!['passwd'] ?? '';
    nameController.text = rxUser.value!['name'] ?? '';
    telephoneController.text = rxUser.value!['telephone'] ?? '';
    cardNumberController.text = rxUser.value!['cardNumber'] ?? '';
    List<XPermission> permissions = [];
    for (var p in SDKController.permissions) {
      permissions.add(p);
      permissions.addAll(p.spread());
    }
    for (var p in permissions) {
      appLanguge.addLocal(p.local);
    }
    rxPermissions.assignAll(permissions);

    Shop().loadTerminalTypes().then((types) {
      rxTerminalTypes.addAll(types);
    });
    Shop().loadEmployes().then((emplyes) {
      rxEmployes.addAll(emplyes.where((element) => element['active'] == true));
      if (rxUser.value?['employe'] != null) {
        for (var ep in rxEmployes) {
          if (ep.id == rxUser.value?['employe']) {
            rxSelectedEmploye.value = ep;
            break;
          }
        }
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    NFCReader.instance.addListener(nfcListener);
    super.onReady();
  }

  showTerminalTypes() async {
    var selectedTypes =
        await UserTerminalTypesRouter().gotoName('/user_terminal_types', args: {'terminalTypes': rxTerminalTypes, 'selected': rxUser.value?['terminalTypes']});
    if (selectedTypes != null) {
      rxUser.value?['terminalTypes'] = selectedTypes;
      rxUser.refresh();
    }
  }

  nfcListener(XNFCValueEvent event) async {
    cardNumberController.text = event.uid;
    setUserValue('cardNumber', event.uid);
  }

  @override
  void onClose() {
    if (result == null) {
      rxUser.value!.reload();
    }
    NFCReader.instance.removeListener(nfcListener);
    super.onClose();
  }

  AccountControler(User user) {
    rxUser.value = user;
  }

  setUserValue(String key, dynamic value) {
    rxUser.value![key] = value;
    rxUser.refresh();
  }

  setEmploye(Employe? ep) {
    rxUser.value?['employe'] = ep?.id;
    rxSelectedEmploye.value = ep;
  }

  setDefault(XPermission f) {
    bool found = false;
    for (var p in rxUser.value!.permissions) {
      if (p['url'] == f.url) {
        found = true;
        if (p['isDefault'] == true) {
          p['isDefault'] = false;
        } else {
          p['isDefault'] = true;
          p['canAccess'] = true;
        }
      } else {
        p['isDefault'] = false;
      }
    }
    if (!found) {
      rxUser.value?.permissions.add({
        'url': f.url,
        'canAccess': false,
        'terminalType': Terminal.currentTerminal!["type"],
        'isDefault': true,
      });
    }
    rxPermissions.refresh();
  }

  selectPermission(XPermission f) {
    if (rxUser.value!['isRoot'] == true) {
      return;
    }
    var idx = rxUser.value!.permissions.indexWhere((up) => up['url'] == f.url);
    if (idx >= 0) {
      var up = rxUser.value!.permissions[idx];
      if (up['canAccess'] == true) {
        rxUser.value!.permissions.removeAt(idx);
      } else if (up['canAccess'] == false) {
        up['canAccess'] = true;
      }
      rxPermissions.refresh();
      return;
    } else {
      rxUser.value!.permissions.add({
        'url': f.url,
        'canAccess': false,
        'terminalType': Terminal.currentTerminal!["type"],
      });
      rxPermissions.refresh();
    }
  }

  save() async {
    if (formKey.currentState!.validate()) {
      isSaving.value = true;
      var r = await rxUser.value!.save();
      isSaving.value = false;
      if (r == true) {
        close(true);
      }
    }
  }

  del() async {
    if (await XController.getConfirm(title: 'account_confirmation', content: 'account_confirmationContent') == true) {
      isSaving.value = true;
      var r = await rxUser.value!.del();
      isSaving.value = false;
      if (r == true) {
        close(false);
      }
    }
  }
}
