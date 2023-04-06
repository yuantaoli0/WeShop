import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sdk/util/format.dart';
import 'package:sdk/util/validator.dart';
import 'package:sdk/views/first_start/controller.dart';
import 'package:sdk/xView.dart';

class CompanyInfoView extends XView<FirstStartController> {
  CompanyInfoView(ctl, {super.key}) : super({}, ctl) {
    controller.companyNameController.text = controller.rxCompany['name'] ?? '';
    controller.signController.text = controller.rxCompany['sign'] ?? '';
    controller.addressController.text = controller.rxCompany['address'] ?? '';
    controller.postCodeController.text = controller.rxCompany['postCode'] ?? '';
    controller.cityController.text = controller.rxCompany['city'] ?? '';
    controller.telephoneController.text = controller.rxCompany['telephone'] ?? '';
    controller.siretController.text = controller.rxCompany['siret'] ?? '';
    controller.rcsController.text = controller.rxCompany['rcsNumber'] ?? '';
    controller.apeController.text = controller.rxCompany['apeCode'] ?? '';
    controller.vatController.text = controller.rxCompany['vatNumber'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Center(
        child: Card(
          child: Container(
            width: Get.width,
            padding: EdgeInsets.all(10.w),
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    key: ctl.companyFormKey,
                    child: ListView(
                      children: [
                        TextFormField(
                          validator: Validator().notEmpty,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          controller: ctl.companySirenController,
                          inputFormatters: [UpperCaseTextFormatter()],
                          focusNode: ctl.companySirenFocus,
                          onChanged: (value) {},
                          onEditingComplete: ctl.getInformationBySiren,
                          enableSuggestions: false,
                          decoration: InputDecoration(
                            labelText: 'first_start_company_siren'.tr,
                            contentPadding: const EdgeInsets.symmetric(vertical: 0),
                            //labelStyle: TextStyle(fontSize: rowSubtitleSize()),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: Validator().notEmpty,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                autocorrect: false,
                                textInputAction: TextInputAction.next,
                                controller: ctl.companyTypeController,
                                inputFormatters: [UpperCaseTextFormatter()],
                                focusNode: ctl.companyTypeFocus,
                                onChanged: (value) {
                                  ctl.setCompanyValue('ctype', value);
                                },
                                onEditingComplete: () {
                                  ctl.companyNameFocus.requestFocus();
                                },
                                enableSuggestions: false,
                                decoration: InputDecoration(
                                  labelText: 'first_start_company_type'.tr,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                  //labelStyle: TextStyle(fontSize: rowSubtitleSize()),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                            ),
                            Expanded(
                              child: TextFormField(
                                validator: Validator().notEmpty,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                autocorrect: false,
                                textInputAction: TextInputAction.next,
                                controller: ctl.companyNameController,
                                inputFormatters: [UpperCaseTextFormatter()],
                                focusNode: ctl.companyNameFocus,
                                onChanged: (value) {
                                  ctl.setCompanyValue('name', value);
                                },
                                onEditingComplete: () {
                                  ctl.signFocus.requestFocus();
                                },
                                enableSuggestions: false,
                                decoration: InputDecoration(
                                  labelText: 'first_start_company_name'.tr,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                  //labelStyle: TextStyle(fontSize: rowSubtitleSize()),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [UpperCaseTextFormatter()],
                          enableSuggestions: false,
                          controller: ctl.signController,
                          focusNode: ctl.signFocus,
                          onChanged: (value) {
                            ctl.setCompanyValue('sign', value);
                          },
                          onEditingComplete: () {
                            ctl.addressFocus.requestFocus();
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 0),
                            labelText: 'first_start_sign'.tr,
                          ),
                        ),
                        TextFormField(
                          validator: Validator().notEmpty,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [UpperCaseTextFormatter()],
                          enableSuggestions: false,
                          controller: ctl.addressController,
                          focusNode: ctl.addressFocus,
                          onChanged: (value) {
                            ctl.setCompanyValue('address', value);
                          },
                          onEditingComplete: () {
                            ctl.postCodeFocus.requestFocus();
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 0),
                            labelText: 'first_start_address'.tr,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: Validator().notEmpty,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                autocorrect: false,
                                textInputAction: TextInputAction.next,
                                enableSuggestions: false,
                                keyboardType: TextInputType.number,
                                controller: ctl.postCodeController,
                                focusNode: ctl.postCodeFocus,
                                onChanged: (value) {
                                  ctl.setCompanyValue('postCode', value);
                                },
                                onEditingComplete: () {
                                  ctl.cityFocus.requestFocus();
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                  labelText: 'first_start_post_code'.tr,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                            ),
                            Expanded(
                              child: TextFormField(
                                validator: Validator().notEmpty,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                enableSuggestions: false,
                                inputFormatters: [UpperCaseTextFormatter()],
                                controller: ctl.cityController,
                                focusNode: ctl.cityFocus,
                                onChanged: (value) {
                                  ctl.setCompanyValue('city', value);
                                },
                                onEditingComplete: () {
                                  ctl.telephoneFocus.requestFocus();
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                  labelText: 'first_start_city'.tr,
                                ),
                              ),
                            )
                          ],
                        ),
                        TextFormField(
                          validator: Validator().notEmpty,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          enableSuggestions: false,
                          controller: ctl.telephoneController,
                          focusNode: ctl.telephoneFocus,
                          onChanged: (value) {
                            ctl.setCompanyValue('telephone', value);
                          },
                          inputFormatters: [UpperCaseTextFormatter()],
                          onEditingComplete: () async {
                            ctl.siretFocus.requestFocus();
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 0),
                            labelText: 'first_start_telephone'.tr,
                          ),
                        ),
                        TextFormField(
                          validator: Validator().notEmpty,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          enableSuggestions: false,
                          controller: ctl.siretController,
                          focusNode: ctl.siretFocus,
                          onChanged: (value) {
                            ctl.setCompanyValue('siret', value);
                          },
                          inputFormatters: [UpperCaseTextFormatter()],
                          onEditingComplete: () async {
                            ctl.rcsFocus.requestFocus();
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 0),
                            labelText: 'first_start_siret'.tr,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: Validator().notEmpty,
                                autocorrect: false,
                                textInputAction: TextInputAction.next,
                                enableSuggestions: false,
                                inputFormatters: [UpperCaseTextFormatter()],
                                controller: ctl.rcsController,
                                focusNode: ctl.rcsFocus,
                                onChanged: (value) {
                                  ctl.setCompanyValue('rcsNumber', value);
                                },
                                onEditingComplete: () {
                                  ctl.greffeFocus.requestFocus();
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                  labelText: 'first_start_RCS'.tr,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                            ),
                            Expanded(
                              child: TextFormField(
                                validator: Validator().notEmpty,
                                autocorrect: false,
                                textInputAction: TextInputAction.next,
                                enableSuggestions: false,
                                inputFormatters: [UpperCaseTextFormatter()],
                                controller: ctl.greffeController,
                                focusNode: ctl.greffeFocus,
                                onChanged: (value) {
                                  ctl.setCompanyValue('greffeCity', value);
                                },
                                onEditingComplete: () {
                                  ctl.apeFocus.requestFocus();
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                  labelText: 'first_start_greffe'.tr,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          validator: Validator().notEmpty,
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          enableSuggestions: false,
                          controller: ctl.apeController,
                          focusNode: ctl.apeFocus,
                          inputFormatters: [UpperCaseTextFormatter()],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            ctl.setCompanyValue('apeCode', value);
                          },
                          onEditingComplete: () {
                            ctl.vatFocus.requestFocus();
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 0),
                            labelText: 'first_start_APE'.tr,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: Validator().notEmpty,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                autocorrect: false,
                                textInputAction: TextInputAction.next,
                                enableSuggestions: false,
                                controller: ctl.vatController,
                                focusNode: ctl.vatFocus,
                                inputFormatters: [UpperCaseTextFormatter()],
                                onEditingComplete: () {
                                  ctl.capitalFocus.requestFocus();
                                },
                                onChanged: (value) {
                                  ctl.setCompanyValue('vatNumber', value);
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                  labelText: 'first_start_vat'.tr,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                            ),
                            Expanded(
                              child: TextFormField(
                                validator: Validator().notEmpty,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                autocorrect: false,
                                textInputAction: TextInputAction.next,
                                enableSuggestions: false,
                                controller: ctl.capitalController,
                                focusNode: ctl.capitalFocus,
                                inputFormatters: [UpperCaseTextFormatter()],
                                onEditingComplete: ctl.validCompany,
                                onChanged: (value) {
                                  ctl.setCompanyValue('capital', value);
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                  labelText: 'first_start_capital'.tr,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text('first_start_prev'.tr),
                      onPressed: ctl.prePage,
                    ),
                    TextButton(
                      child: Text('first_start_next'.tr),
                      onPressed: ctl.validCompany,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
