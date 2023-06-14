import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:convert/convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';

class WorkController extends GetxController {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  RxBool cardReadError = RxBool(false);
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startNfcSession();
  }

  void startNfcSession() {
    _timer = Timer(const Duration(seconds: 3), () {
      Get.offAllNamed('/home');
    });
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      _timer?.cancel();
      _timer = Timer(const Duration(seconds: 3), () {
        Get.offAllNamed('/home');
      });

      result.value = tag.data;
      if (tag != null &&
          tag.data != null &&
          tag.data.containsKey('mifareclassic') &&
          tag.data['mifareclassic'] != null &&
          tag.data['mifareclassic'].containsKey('identifier') &&
          tag.data['mifareclassic']['identifier'] != null) {
        var uid = hex
            .encode(tag.data['mifareclassic']['identifier'].reversed.toList());
        uid = int.tryParse(uid, radix: 16).toString();
        uid = uid.padLeft(10, '0');
        print("----------------------------$uid");
        cardReadError.value = false;
      } else {
        cardReadError.value = true;
      }

      if (cardReadError.value) {
        // 只有当卡片读取错误时，才显示 Snackbar
        Get.snackbar(
          'error_title'.tr,
          'error'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          icon: const Icon(Icons.error, color: Colors.white),
        );
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel(); // 在控制器关闭时取消操作
  }
}
