import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/models/employe.dart';
import 'package:sdk/util/format.dart';
import 'package:sdk/xcontroller.dart';

class EmployeController extends XController {
  Rx<Employe?> rxEmploye = Rx(null);
  TextEditingController nameController = TextEditingController();
  FocusNode nameNode = FocusNode();
  TextEditingController birthdayController = TextEditingController();
  FocusNode birthdaytNode = FocusNode();
  TextEditingController nationnalityController = TextEditingController();
  FocusNode nationnalityNode = FocusNode();
  TextEditingController cardNumberController = TextEditingController();
  FocusNode cardNumberNode = FocusNode();
  TextEditingController addressController = TextEditingController();
  FocusNode addressNode = FocusNode();
  TextEditingController postCodeController = TextEditingController();
  FocusNode postCodeNode = FocusNode();
  TextEditingController cityController = TextEditingController();
  FocusNode cityNode = FocusNode();
  TextEditingController telephoneController = TextEditingController();
  FocusNode telephoneNode = FocusNode();
  TextEditingController socialSecurityNumberController = TextEditingController();
  FocusNode socialSecurityNumberNode = FocusNode();
  TextEditingController salaryController = TextEditingController();
  FocusNode salaryNode = FocusNode();
  TextEditingController commentController = TextEditingController();
  FocusNode commentNode = FocusNode();
  EmployeController(Employe employe) {
    rxEmploye.value = employe;
    nameController.text = employe['name'] ?? '';
    birthdayController.text = format.date(employe['birthday']) ?? '';
    nationnalityController.text = employe['nationnality'] ?? '';
    cardNumberController.text = employe['cardNumber'] ?? '';
    addressController.text = employe['address'] ?? '';
    postCodeController.text = employe['postCode'] ?? '';
    cityController.text = employe['city'] ?? '';
    telephoneController.text = employe['telephone'] ?? '';
    socialSecurityNumberController.text = employe['socialSecurityNumber'] ?? '';
    salaryController.text = employe['salary'] ?? '';
    commentController.text = employe['comment'] ?? '';
  }

  @override
  void accept() async {
    var r = await rxEmploye.value?.save();
    if (r == true) {
      super.accept();
    }
  }

  setEmployeValue(String key, dynamic value) {
    rxEmploye.value?[key] = value;
    rxEmploye.refresh();
  }

  setBirthday() async {
    var birthday = await showDatePicker(
      context: Get.context!,
      initialDate: rxEmploye.value?.birthday ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime(3000, 1, 1),
    );
    birthdayController.text = format.date(birthday) ?? "";
    rxEmploye.value?.birthday = birthday;
  }

  delEmploye() async {
    if (await XController.getConfirm(title: 'Confirmation', content: 'Vous etes sur?') == true) {
      await rxEmploye.value?.del();
      close(false);
    }
  }
}
