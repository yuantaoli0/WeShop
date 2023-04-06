import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sdk/views/first_start/controller.dart';
import 'package:sdk/xView.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmView extends XView<FirstStartController> {
  ConfirmView(ctl, {super.key}) : super({}, ctl) {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ctl.rxIsSubmiting.value == true
          ? const CupertinoActivityIndicator()
          : Card(
              child: Container(
                width: Get.width,
                padding: EdgeInsets.all(10.w),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Text(
                            'first_start_account'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(decoration: TextDecoration.underline),
                          ),
                          Text(
                            'first_start_user_name'.tr + ':' + (ctl.rxUser['name'] ?? ''),
                          ),
                          Text(
                            'first_start_login'.tr + ':' + (ctl.rxUser['login'] ?? ''),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                          ),
                          Text(
                            'first_start_company_info'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(decoration: TextDecoration.underline),
                          ),
                          Text(
                            'first_start_company_name'.tr + ':' + (ctl.rxCompany['type'] ?? '') + ' ' + (ctl.rxCompany['name'] ?? ''),
                          ),
                          Text(
                            'first_start_sign'.tr + ':' + (ctl.rxCompany['sign'] ?? ''),
                          ),
                          Text(
                            'first_start_address'.tr + ':' + (ctl.rxCompany['address'] ?? ''),
                          ),
                          Text(
                            'first_start_post_code'.tr + ':' + (ctl.rxCompany['postCode'] ?? ''),
                          ),
                          Text(
                            'first_start_city'.tr + ':' + (ctl.rxCompany['city'] ?? ''),
                          ),
                          Text(
                            'first_start_telephone'.tr + ':' + (ctl.rxCompany['telephone'] ?? ''),
                          ),
                          Text(
                            'first_start_siret'.tr + ':' + (ctl.rxCompany['siret'] ?? ''),
                          ),
                          Text(
                            'first_start_RCS'.tr + ':' + (ctl.rxCompany['rcsNumber'] ?? ''),
                          ),
                          Text(
                            'first_start_greffe'.tr + ':' + (ctl.rxCompany['greffeCity'] ?? ''),
                          ),
                          Text(
                            'first_start_APE'.tr + ':' + (ctl.rxCompany['apeCode'] ?? ''),
                          ),
                          Text(
                            'first_start_vat'.tr + ':' + (ctl.rxCompany['vatNumber'] ?? ''),
                          ),
                          Text(
                            'first_start_capital'.tr + ':' + (ctl.rxCompany['capital'] ?? ''),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: ctl.prePage,
                          child: Text('first_start_prev'.tr),
                        ),
                        Obx(
                          () => TextButton(
                            onPressed: ctl.submit,
                            child: ctl.rxIsSubmiting.value == true ? const CupertinoActivityIndicator() : Text('first_start_submit'.tr),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
