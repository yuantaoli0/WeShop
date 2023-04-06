import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sdk/language.dart';
import 'package:sdk/util/validator.dart';
import 'package:sdk/xView.dart';
import 'package:get/get.dart';
import 'package:sdk/xcontroller.dart';
import 'controller.dart';
import 'local.dart';

class View extends XView<EmployeController> {
  View(args, EmployeController ctl, {super.key}) : super(args, ctl) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('employe_title'.tr),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              ctl.delEmploye();
            },
            icon: const Icon(AntDesign.delete),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
                children: [
                  obx(
                    () => SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        ctl.rxEmploye.value?['avatarUrl'] ?? '',
                        errorBuilder: ((context, error, stackTrace) {
                          return const Text('Telecharge photo');
                        }),
                      ),
                    ),
                  ),
                  obx(() => DropdownButtonFormField(
                      value: ctl.rxEmploye.value?['sex'],
                      items: ['man', 'woman'].map<DropdownMenuItem<String>>(((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text('employe_$e'.tr),
                        );
                      })).toList(),
                      onChanged: (v) {
                        ctl.setEmployeValue('sex', v);
                      })),
                  TextFormField(
                    controller: ctl.nameController,
                    focusNode: ctl.nameNode,
                    validator: Validator().notEmpty,
                    decoration: InputDecoration(
                      hintText: 'employe_name'.tr,
                    ),
                    onChanged: (value) {
                      ctl.setEmployeValue('name', value);
                    },
                    onEditingComplete: () {
                      ctl.nationnalityNode.requestFocus();
                    },
                  ),
                  TextFormField(
                    controller: ctl.nationnalityController,
                    focusNode: ctl.nationnalityNode,
                    decoration: InputDecoration(
                      hintText: 'employe_nationality'.tr,
                    ),
                    onChanged: (value) {
                      ctl.setEmployeValue('nationality', value);
                    },
                    onEditingComplete: () {
                      ctl.birthdaytNode.requestFocus();
                    },
                  ),
                  TextFormField(
                    readOnly: true,
                    onTap: ctl.setBirthday,
                    controller: ctl.birthdayController,
                    focusNode: ctl.birthdaytNode,
                    validator: Validator().notEmpty,
                    decoration: InputDecoration(
                      hintText: 'employe_birthday'.tr,
                    ),
                  ),
                  TextFormField(
                    controller: ctl.cardNumberController,
                    focusNode: ctl.cardNumberNode,
                    decoration: InputDecoration(
                      hintText: 'employe_cardNumber'.tr,
                    ),
                    onChanged: (value) {
                      ctl.setEmployeValue('cardNumber', value);
                    },
                    onEditingComplete: () {
                      ctl.addressNode.requestFocus();
                    },
                  ),
                  TextFormField(
                    controller: ctl.addressController,
                    focusNode: ctl.addressNode,
                    decoration: InputDecoration(
                      hintText: 'employe_address'.tr,
                    ),
                    onChanged: (value) {
                      ctl.setEmployeValue('address', value);
                    },
                    onEditingComplete: () {
                      ctl.postCodeNode.requestFocus();
                    },
                  ),
                  TextFormField(
                    controller: ctl.postCodeController,
                    focusNode: ctl.postCodeNode,
                    decoration: InputDecoration(
                      hintText: 'employe_postCode'.tr,
                    ),
                    onChanged: (value) {
                      ctl.setEmployeValue('postCode', value);
                    },
                    onEditingComplete: () {
                      ctl.cityNode.requestFocus();
                    },
                  ),
                  TextFormField(
                    controller: ctl.cityController,
                    focusNode: ctl.cityNode,
                    decoration: InputDecoration(
                      hintText: 'employe_city'.tr,
                    ),
                    onChanged: (value) {
                      ctl.setEmployeValue('city', value);
                    },
                    onEditingComplete: () {
                      ctl.telephoneNode.requestFocus();
                    },
                  ),
                  TextFormField(
                    controller: ctl.telephoneController,
                    focusNode: ctl.telephoneNode,
                    decoration: InputDecoration(
                      hintText: 'employe_telephone'.tr,
                    ),
                    onChanged: (value) {
                      ctl.setEmployeValue('telephone', value);
                    },
                    onEditingComplete: () {
                      ctl.socialSecurityNumberNode.requestFocus();
                    },
                  ),
                  TextFormField(
                    controller: ctl.socialSecurityNumberController,
                    focusNode: ctl.socialSecurityNumberNode,
                    decoration: InputDecoration(
                      hintText: 'employe_socialSecurityNumber'.tr,
                    ),
                    onChanged: (value) {
                      ctl.setEmployeValue('socialSecurityNumber', value);
                    },
                    onEditingComplete: () {
                      ctl.commentNode.requestFocus();
                    },
                  ),
                  obx(
                    () => Row(
                      children: [
                        Text('employe_active'.tr),
                        Switch(
                            value: ctl.rxEmploye.value?['active'] ?? true,
                            onChanged: (v) {
                              ctl.setEmployeValue('active', v);
                            }),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: ctl.commentController,
                    focusNode: ctl.commentNode,
                    minLines: 3,
                    maxLines: 5,
                    textInputAction: TextInputAction.done,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      hintText: 'employe_comment'.tr,
                    ),
                    onChanged: (value) {
                      ctl.setEmployeValue('comment', value);
                    },
                    onEditingComplete: () {
                      ctl.hideKeyboard();
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
            width: double.maxFinite,
            child: ElevatedButton(
              child: Text('employe_OK'.tr),
              onPressed: () {
                ctl.accept();
              },
            ),
          ),
        ],
      ),
    );
  }
}
