import 'package:get/get.dart';
import 'package:sdk/models/shop.dart';
import 'package:sdk/models/terminal.dart';
import 'package:sdk/xcontroller.dart';
import 'package:system_info2/system_info2.dart';

import '../appUpdater/router.dart';
import 'ask_one_time_password/router.dart';
import 'license_editor.dart/router.dart';

class AboutController extends XController {
  RxMap rxSoftware = RxMap();
  RxMap rxShop = RxMap();
  RxMap rxEditor = RxMap();
  static RxString rxTitle = "".obs;
  var isLoading = true.obs;
  String? imageUrl;
  @override
  void onInit() {
    isLoading.value = true;
    Shop().getShopInformation().then((data) {
      rxSoftware.assignAll(data['software']);
      rxShop.assignAll(data['shop']);
      isLoading.value = false;
    }).catchError((_) {
      isLoading.value = false;
    });

    super.onInit();
  }

  modify() async {
    var r = await AskOneTimePasswordRouter().gotoName('/askOneTimePassword');
    if (r is Map) {
      r = await LisenceEditorRouter().gotoName('/licenseEditor', args: {'code': r['code'], 'days': r['days'], 'shop': rxShop.toJson()});
      if (r == true) {
        Shop().getShopInformation().then((data) {
          rxSoftware.assignAll(data['software']);
          rxShop.assignAll(data['shop']);
          isLoading.value = false;
        }).catchError((_) {
          isLoading.value = false;
        });
      }
    }
  }

  updateApp() async {
    if (await XController.getConfirm(title: '', content: 'Vous vous mettre à jour l\'application?') == true) {
      var arch = SysInfo.kernelArchitecture;
      AppUpdaterRouter().gotoName('/appUpdater',
          args: {'newVersion': '2.0', 'msg': 'Mis a jour', 'url': 'http://weshop.fr/downloads/weshopx-2022.apk?arch=$arch&siret=${rxShop['siret']}'});
    }
  }
}
