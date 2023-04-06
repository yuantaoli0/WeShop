import 'package:get/get.dart';
import 'package:ota_update/ota_update.dart';
import 'package:sdk/util/format.dart';
import 'package:sdk/xcontroller.dart';
import 'package:system_info2/system_info2.dart';

class AppUpdaterController extends XController {
  String? newVersion;
  String? msg;
  String? url;

  RxDouble rxProgressValue = 0.0.obs;
  RxString rxUpdateStatus = "".obs;

  AppUpdaterController(this.newVersion, this.msg, this.url);

  @override
  void onReady() {
    try {
      //LINK CONTAINS APK OF FLUTTER HELLO WORLD FROM FLUTTER SDK EXAMPLES
      var arch = SysInfo.kernelArchitecture;
      OtaUpdate()
          .execute(
        url != null && url != "" ? url! : 'http://weshop.fr/downloads/weco-work.apk?arch=$arch',
        // OPTIONAL
        destinationFilename: 'weshopx-2022.apk',
        //OPTIONAL, ANDROID ONLY - ABILITY TO VALIDATE CHECKSUM OF FILE:
        //sha256checksum: "d6da28451a1e15cf7a75f2c3f151befad3b80ad0bb232ab15c20897e54f21378",
      )
          .listen((OtaEvent event) {
        if (event.status == OtaStatus.DOWNLOADING) {
          rxProgressValue.value = format.parse(event.value)! / 100;
          rxUpdateStatus.value = "app_updater_downloaded".tr + format.percent(rxProgressValue.value)!;
        }
        if (event.status == OtaStatus.INSTALLING) {
          rxProgressValue.value = 1;
          rxUpdateStatus.value = "app_updater_select_install".tr;
        }
      });
    } catch (e) {
      rxUpdateStatus.value = "app_updater_update_error".tr + e.toString();
    }
    super.onReady();
  }
}
