import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sdk/models/terminal.dart';
import 'package:sdk/models/user.dart';
import 'package:sdk/persmission.dart';
import 'package:sdk/util/format.dart';
import 'package:sdk/util/nfc_reader.dart';
import 'package:sdk/xcontroller.dart';

class RequestPermissionController extends XController {
  XPermission permission;
  String? message;
  static Rx<User?> rxSelectedUser = Rx(null);
  RxList<User> rxUsers = RxList([]);
  var isLoading = false.obs;
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocus = FocusNode();
  RequestPermissionController(this.permission, this.message) {
    rxUsers.assignAll(Terminal.currentTerminal!.users);
    if (rxSelectedUser.value == null) {
      for (var u in rxUsers) {
        if (u.id == User.currentUser?.id) {
          rxSelectedUser.value = u;
          break;
        }
      }
    }
  }

  @override
  onReady() {
    if (rxSelectedUser.value != null) {
      passwordFocus.requestFocus();
    }
    /*FlutterNfcKit.nfcAvailability.then((value) {
      if (value == NFCAvailability.available) {
        FlutterNfcKit.poll().then((tag) async {
          if (tag.type == NFCTagType.mifare_classic) {
            //print(tag.toJson());
            var ndefRecords = await FlutterNfcKit.readNDEFRecords();
            //print(jsonEncode(ndefRecords).toString());
            var ndefString = ndefRecords.map((r) => r.toString()).reduce((value, element) => value + "\n" + element);
            //print(ndefString);
          }
        });
      }
    }).catchError((ex) {
      print(ex.toString());
    });*/
    NFCReader.instance.addListener(nfcListener);
    /*if (message != null && message.isNotEmpty) {
      XController.showMessage(message, isDialog: true);
    }*/
    super.onReady();
  }

  nfcListener(XNFCValueEvent event) async {
    var res = await User.currentUser!.requestPermission(
      permission.url,
      permission.name,
      cardNumber: event.uid,
    );
    if (res == true) {
      Get.back(result: true);
    } else {
      return;
    }
  }

  @override
  onClose() {
    NFCReader.instance.removeListener(nfcListener);
    super.onClose();
  }

  selectUser(User? u) {
    rxSelectedUser.value = u;
    XController.requestFocus(passwordFocus);
  }

  physiqueKeyboard(RawKeyEvent key) {
    if (key is RawKeyDownEvent) {
      if (key.character != null && format.isAlphanumeric(key.character)) {
        input(key.character!);
      }

      if (key.logicalKey == LogicalKeyboardKey.backspace) {
        input('\b');
      }
      if (key.character == '\n') {
        input('\n');
      }
    }
  }

  input(String key) async {
    TextEditingController? editor = passwordController;

    String newText = editor.text;
    TextSelection selection = editor.selection;
    if (key == '\b' && newText != '') {
      editor.text = newText.substring(0, editor.text.length - 1);
      return;
    }
    if (key == '\r') {
      editor.text = '';
      return;
    }
    if (key == '\n') {
      if (rxSelectedUser.value == null) {
        return;
      }
      if (permission.askLocalAuth == true) {
        if (rxSelectedUser.value != null && rxSelectedUser.value!['login'] == User.currentUser!['login']) {
          if (editor.text == User.currentUser!['passwd']) {
            Get.back(result: true);
          } else {
            Get.back(result: false);
          }
        }
      } else {
        var res = await User.currentUser?.requestPermission(
          permission.url,
          permission.name,
          login: rxSelectedUser.value!['login'],
          passwd: editor.text,
        );
        if (res == true) {
          Get.back(result: true);
        } else {
          return;
        }
      }
    } else {
      editor.value = editor.value.copyWith(
        text: newText + key,
        selection: selection,
        composing: TextRange.empty,
      );
    }
  }
}
