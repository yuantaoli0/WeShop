import 'dart:async';
import 'dart:convert';
import 'package:convert/convert.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'local.dart';

class HomeController extends GetxController {
  Rx<DateTime> currentTime = Rx<DateTime>(DateTime.now());
  ValueNotifier<dynamic> result = ValueNotifier(null);
  RxBool cardReadError = RxBool(false);

  //  appLanguge.addLocal(XLocal());

  @override
  void onInit() {
    super.onInit();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      currentTime.value = DateTime.now();
    });

    startNfcSession();
  }

  void startNfcSession() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      NfcManager.instance.stopSession();
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
        Get.toNamed('/option');
        cardReadError.value = false;
      } else {
        cardReadError.value = true;
        startNfcSession();
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

  // result.addListener(
  //   () {
  //     if (result.value != null &&
  //         currentTime.value.hour >= 8 &&
  //         currentTime.value.hour <= 18) {
  //       // tagRead();
  //       Get.toNamed('/option');
  //     }
  //   },
  // );

  void tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      NfcManager.instance.stopSession();
    });

    String jsons = jsonEncode(result.value);
    String formattedJsons =
        JsonEncoder.withIndent('  ').convert(jsonDecode(jsons));

    print(formattedJsons);

    if (formattedJsons != null) {
      Map<String, dynamic> data = jsonDecode(formattedJsons);

      // Access the values
      Map<String, dynamic> mifareClassic = data['mifareclassic'];
      List<int> identifier =
          (mifareClassic['identifier'] as List<dynamic>).cast<int>();

      int blockCount = mifareClassic['blockCount'];
      int maxTransceiveLength = mifareClassic['maxTransceiveLength'];
      int sectorCount = mifareClassic['sectorCount'];
      int size = mifareClassic['size'];
      int timeout = mifareClassic['timeout'];
      int type = mifareClassic['type'];

      Map<String, dynamic> nfca = data['nfca'];
      List<int> nfcaIdentifier =
          (nfca['identifier'] as List<dynamic>).cast<int>();

      List<int> atqa = (nfca['atqa'] as List<dynamic>).cast<int>();
      int nfcaMaxTransceiveLength = nfca['maxTransceiveLength'];
      int sak = nfca['sak'];
      int nfcaTimeout = nfca['timeout'];

      Map<String, dynamic> ndefformatable = data['ndefformatable'];
      List<int> ndefformatableIdentifier =
          (ndefformatable['identifier'] as List<dynamic>).cast<int>();

      // Use the values as needed
      print(identifier); // [234, 69, 83, 3]
      print(blockCount); // 64
      print(maxTransceiveLength); // 253
      print(sectorCount); // 16
      print(size); // 1024
      print(timeout); // 618
      print(type); // 0

      print(nfcaIdentifier); // [234, 69, 83, 3]
      print(atqa); // [4, 0]
      print(nfcaMaxTransceiveLength); // 253
      print(sak); // 8
      print(nfcaTimeout); // 618

      print(ndefformatableIdentifier); // [234, 69, 83, 3]
    } else {
      print("NfcManager.isAvailable()");
    }
  }
}
