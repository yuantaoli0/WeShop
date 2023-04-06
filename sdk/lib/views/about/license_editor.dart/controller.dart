import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/models/shop.dart';
import 'package:sdk/xcontroller.dart';

class LicenseEditorController extends XController {
  String otpCode;
  int days = 0;
  Map shop;
  RxMap? rxLicense;
  RxBool rxIsSaving = false.obs;

  TextEditingController companyController = TextEditingController();
  TextEditingController companyTypeController = TextEditingController();
  TextEditingController signController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController siretController = TextEditingController();
  TextEditingController rcsController = TextEditingController();
  TextEditingController greffeController = TextEditingController();
  TextEditingController apeCodeController = TextEditingController();
  TextEditingController vatNumberController = TextEditingController();
  TextEditingController capitalController = TextEditingController();
  FocusNode companyFocus = FocusNode();
  FocusNode companyTypeFocus = FocusNode();
  FocusNode signFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  FocusNode postcodeFocus = FocusNode();
  FocusNode cityFocus = FocusNode();
  FocusNode telephoneFocus = FocusNode();
  FocusNode siretFocus = FocusNode();
  FocusNode rcsFocus = FocusNode();
  FocusNode greffeFocus = FocusNode();
  FocusNode apeCodeFocus = FocusNode();
  FocusNode vatNumberFocus = FocusNode();
  FocusNode capitalFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  LicenseEditorController(this.otpCode, this.days, this.shop);

  @override
  void onInit() {
    rxLicense = shop.obs;
    rxLicense!["otpCode"] = this.otpCode;
    rxLicense!['endDate'] = DateTime.now().add(Duration(days: days));
    companyTypeController.text = rxLicense!['ctype'];
    companyController.text = rxLicense!['name'];
    signController.text = rxLicense!['sign'];
    addressController.text = rxLicense!['address'];
    postCodeController.text = rxLicense!['postCode'];
    cityController.text = rxLicense!['city'];
    telephoneController.text = rxLicense!['telephone'];
    siretController.text = rxLicense!['siret'];
    rcsController.text = rxLicense!['rcsNumber'];
    greffeController.text = rxLicense!['greffeCity'];
    apeCodeController.text = rxLicense!['apeCode'];
    vatNumberController.text = rxLicense!['vatNumber'];
    capitalController.text = rxLicense!['capital'].toString();
    super.onInit();
  }

  setLicenseValue(String key, value) {
    rxLicense![key] = value;
  }

  submit() async {
    if (formKey.currentState!.validate()) {
      rxIsSaving.value = true;
      var r = await Shop().postLisence(rxLicense);
      rxIsSaving.value = false;
      if (r == true) {
        close(true);
      }
    }
  }
}
