import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sdk/language.dart';
import 'package:sdk/util/format.dart';
import 'package:sdk/util/validator.dart';
import 'package:sdk/xpage.dart';
import 'package:sdk/xView.dart';

import 'controller.dart';
import 'local.dart';

class PhoneView extends XView<LicenseEditorController> {
  PhoneView(args, ctl, {super.key}) : super(args, ctl) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    return XPage(
      appBar: AppBar(
        title: Text(
          'license_editor_title'.tr,
          style: scaffoldTitleStyle()?.copyWith(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: ctl.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixText: '*',
                              prefixStyle: const TextStyle(color: Colors.red),
                              labelText: 'license_editor_company_type'.tr,
                              contentPadding: const EdgeInsets.symmetric(vertical: 0),
                              labelStyle: const TextStyle(fontSize: 15),
                            ),
                            style: const TextStyle(fontSize: 15),
                            textInputAction: TextInputAction.next,
                            focusNode: ctl.companyTypeFocus,
                            controller: ctl.companyTypeController,
                            onChanged: (text) {
                              ctl.setLicenseValue('ctype', text);
                            },
                            validator: Validator().notEmpty,
                            onFieldSubmitted: (text) {
                              ctl.companyFocus.requestFocus();
                            },
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixText: '*',
                              prefixStyle: const TextStyle(color: Colors.red),
                              labelText: 'license_editor_company'.tr,
                              contentPadding: const EdgeInsets.symmetric(vertical: 0),
                              labelStyle: const TextStyle(fontSize: 15),
                            ),
                            style: const TextStyle(fontSize: 15),
                            textInputAction: TextInputAction.next,
                            focusNode: ctl.companyFocus,
                            controller: ctl.companyController,
                            onChanged: (text) {
                              ctl.setLicenseValue('name', text);
                            },
                            validator: Validator().notEmpty,
                            onFieldSubmitted: (text) {
                              ctl.signFocus.requestFocus();
                            },
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: ctl.signController,
                      focusNode: ctl.signFocus,
                      decoration: InputDecoration(
                        labelText: 'license_editor_sign'.tr,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      style: const TextStyle(fontSize: 15),
                      onChanged: (text) {
                        ctl.setLicenseValue('sign', text);
                      },
                      onFieldSubmitted: (text) {
                        ctl.addressFocus.requestFocus();
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          'license_editor_valid_period'.tr,
                          style: const TextStyle(fontSize: 15),
                        ),
                        Obx(() => Text(
                              '${format.date(ctl.rxLicense!['startDate'])!} - ${format.date(ctl.rxLicense!['endDate'])!}',
                              style: const TextStyle(fontSize: 15),
                            )),
                      ],
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixText: '*',
                        prefixStyle: const TextStyle(color: Colors.red),
                        labelText: 'license_editor_address'.tr,
                        labelStyle: const TextStyle(fontSize: 15),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                      inputFormatters: [UpperCaseTextFormatter()],
                      style: const TextStyle(fontSize: 15),
                      controller: ctl.addressController,
                      focusNode: ctl.addressFocus,
                      textInputAction: TextInputAction.next,
                      onChanged: (text) {
                        ctl.setLicenseValue('address', text);
                      },
                      validator: Validator().notEmpty,
                      onFieldSubmitted: (text) {
                        ctl.postcodeFocus.requestFocus();
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixText: '*',
                        prefixStyle: const TextStyle(color: Colors.red),
                        labelText: 'license_editor_postcode'.tr,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      style: const TextStyle(fontSize: 15),
                      controller: ctl.postCodeController,
                      focusNode: ctl.postcodeFocus,
                      textInputAction: TextInputAction.next,
                      onChanged: (text) {
                        ctl.setLicenseValue('postCode', text);
                      },
                      validator: Validator().notEmpty,
                      onFieldSubmitted: (text) {
                        ctl.cityFocus.requestFocus();
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixText: '*',
                        prefixStyle: const TextStyle(color: Colors.red),
                        labelText: 'license_editor_city'.tr,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      style: const TextStyle(fontSize: 15),
                      controller: ctl.cityController,
                      focusNode: ctl.cityFocus,
                      textInputAction: TextInputAction.next,
                      onChanged: (text) {
                        ctl.setLicenseValue('city', text);
                      },
                      validator: Validator().notEmpty,
                      onFieldSubmitted: (text) {
                        ctl.telephoneFocus.requestFocus();
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixText: '*',
                        prefixStyle: const TextStyle(color: Colors.red),
                        labelText: 'license_editor_telephone'.tr,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      style: const TextStyle(fontSize: 15),
                      controller: ctl.telephoneController,
                      focusNode: ctl.telephoneFocus,
                      textInputAction: TextInputAction.next,
                      onChanged: (text) {
                        ctl.setLicenseValue('telephone', text);
                      },
                      validator: Validator().notEmpty,
                      onFieldSubmitted: (text) {
                        ctl.siretFocus.requestFocus();
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixText: '*',
                        prefixStyle: const TextStyle(color: Colors.red),
                        labelText: 'license_editor_siret'.tr,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      style: const TextStyle(fontSize: 15),
                      controller: ctl.siretController,
                      focusNode: ctl.siretFocus,
                      textInputAction: TextInputAction.next,
                      onChanged: (text) {
                        ctl.setLicenseValue('siret', text);
                      },
                      validator: Validator().notEmpty,
                      onFieldSubmitted: (text) {
                        ctl.rcsFocus.requestFocus();
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixText: '*',
                        prefixStyle: const TextStyle(color: Colors.red),
                        labelText: 'license_editor_rcs'.tr,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      style: const TextStyle(fontSize: 15),
                      controller: ctl.rcsController,
                      focusNode: ctl.rcsFocus,
                      textInputAction: TextInputAction.next,
                      onChanged: (text) {
                        ctl.setLicenseValue('rcsNumber', text);
                      },
                      validator: Validator().notEmpty,
                      onFieldSubmitted: (text) {
                        ctl.greffeFocus.requestFocus();
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixText: '*',
                        prefixStyle: const TextStyle(color: Colors.red),
                        labelText: 'license_editor_greffe'.tr,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      style: const TextStyle(fontSize: 15),
                      controller: ctl.greffeController,
                      focusNode: ctl.greffeFocus,
                      textInputAction: TextInputAction.next,
                      onChanged: (text) {
                        ctl.setLicenseValue('greffeCity', text);
                      },
                      validator: Validator().notEmpty,
                      onFieldSubmitted: (text) {
                        ctl.apeCodeFocus.requestFocus();
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixText: '*',
                        prefixStyle: const TextStyle(color: Colors.red),
                        labelText: 'license_editor_apeCode'.tr,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      style: const TextStyle(fontSize: 15),
                      controller: ctl.apeCodeController,
                      focusNode: ctl.apeCodeFocus,
                      textInputAction: TextInputAction.next,
                      onChanged: (text) {
                        ctl.setLicenseValue('apeCode', text);
                      },
                      validator: Validator().notEmpty,
                      onFieldSubmitted: (text) {
                        ctl.vatNumberFocus.requestFocus();
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixText: '*',
                        prefixStyle: const TextStyle(color: Colors.red),
                        labelText: 'license_editor_vatNumber'.tr,
                        //contentPadding: EdgeInsets.symmetric(vertical: 0),
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      style: const TextStyle(fontSize: 15),
                      controller: ctl.vatNumberController,
                      focusNode: ctl.vatNumberFocus,
                      textInputAction: TextInputAction.next,
                      onChanged: (text) {
                        ctl.setLicenseValue('vatNumber', text);
                      },
                      validator: Validator().notEmpty,
                      onFieldSubmitted: (value) async {
                        //ctl.submit();
                        ctl.capitalFocus.requestFocus();
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixText: '*',
                        prefixStyle: const TextStyle(color: Colors.red),
                        labelText: 'license_editor_capital'.tr,
                        //contentPadding: EdgeInsets.symmetric(vertical: 0),
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      style: const TextStyle(fontSize: 15),
                      controller: ctl.capitalController,
                      focusNode: ctl.capitalFocus,
                      textInputAction: TextInputAction.done,
                      onChanged: (text) {
                        ctl.setLicenseValue('capital', text);
                      },
                      validator: Validator().notEmpty,
                      onFieldSubmitted: (value) async {
                        ctl.submit();
                      },
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor(),
              ),
              onPressed: ctl.submit,
              child: SizedBox(
                height: footButtonHeight(),
                width: Get.width,
                child: Center(
                  child: Obx(
                    () => ctl.rxIsSaving.value == true ? const CupertinoActivityIndicator() : Text('license_editor_ok'.tr),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
