import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:sdk/language.dart';
import 'package:sdk/util/format.dart';
import 'package:sdk/xView.dart';
import 'controller.dart';
import 'local.dart';

class TabletView extends XView<AboutController> {
  TabletView(args, AboutController ctl) : super(args, ctl) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: obx(
          () => Text(
            AboutController.rxTitle.value == '' ? 'about_title'.tr : AboutController.rxTitle.value,
          ),
        ),
        centerTitle: true,
      ),
      drawer: systemMenuDrawer,
      body: Center(
        child: Obx(
          () => ctl.isLoading.value == true || ctl.rxSoftware.isEmpty
              ? const CupertinoActivityIndicator()
              : Card(
                  child: SizedBox(
                    width: isPhone ? 300 : Get.width / 2,
                    child: isPhone
                        ? Column(children: buildContent())
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: buildContent(),
                          ),
                  ),
                ),
        ),
      ),
    );
  }

  List<Widget> buildContent() {
    return [
      SizedBox(
          child: ctl.imageUrl != null
              ? Image.asset(
                  ctl.imageUrl!,
                  fit: BoxFit.fill,
                  width: 200,
                  height: 200,
                )
              : Container()),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10.w),
              //width: 290,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'about_editorTitle'.tr,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${'about_company'.tr}: WESHOP',
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  Text(
                    '${'about_address'.tr}: 8 AV HENRI BARBUSSE 93000 BOBIGNY',
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  InkWell(
                    onTap: ctl.updateApp,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${'about_version'.tr} :  ${ctl.rxSoftware['softwareName']}  ${ctl.rxSoftware['softwareVersion']}",
                          style: const TextStyle(
                            fontSize: 13,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10.w, 20.h, 0, 0),
              //width: 290,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: const Icon(
                          Entypo.edit,
                          size: 20,
                        ),
                        onPressed: ctl.modify,
                      ),
                      Text(
                        'about_userTitle'.tr, //'Information Utilisateur',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  obx(
                    () => Text(
                      '${'about_company'.tr + ': ' + (ctl.rxShop['ctype'] ?? '')} ' +
                          ctl.rxShop['name'] +
                          (ctl.rxShop['sign'] == null || ctl.rxShop['sign'] == '' ? '' : '${'(' + ctl.rxShop['sign']})'),
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),
                  obx(
                    () => Text(
                      '${'about_address'.tr + ': ' + ctl.rxShop['address'] + ' ' + ctl.rxShop['postCode']} ' + ctl.rxShop['city'],
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),
                  obx(
                    () => Text(
                      '${'License: de ${format.date(ctl.rxShop['startDate'])!}'} à ${format.date(ctl.rxShop['endDate'])!}',
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),
                  obx(
                    () => Text(
                      'SIRET: ' + ctl.rxShop['siret'],
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),
                  obx(
                    () => Text(
                      'RCS: ' + ctl.rxShop['rcsNumber'],
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),
                  obx(
                    () => Text(
                      'greffe du: ' + (ctl.rxShop['greffeCity'] ?? ''),
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),
                  obx(
                    () => Text(
                      'TVA: ' + ctl.rxShop['vatNumber'],
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),
                  obx(
                    () => Text(
                      'Capital: ${ctl.rxShop['capital'] ?? 0}',
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
