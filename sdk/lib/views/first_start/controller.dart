import 'package:flutter/material.dart';
import 'package:sdk/language.dart';
import 'package:sdk/models/shop.dart';
import 'package:sdk/models/terminal.dart';
import 'package:sdk/xcontroller.dart';
import 'package:get/get.dart';
import 'local.dart';

class FirstStartController extends XController {
  PageController? pageController;
  List<String> titles = [];
  RxInt rxCurrentPageIndex = 0.obs;
  RxBool rxIsSubmiting = false.obs;

  //root账号信息控件
  RxMap rxUser = RxMap({});
  var userFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  FocusNode nameFocus = FocusNode();
  FocusNode loginFocus = FocusNode();
  FocusNode passwdFocus = FocusNode();

  //公司信息控件
  RxMap rxCompany = RxMap({});
  var companyFormKey = GlobalKey<FormState>();
  TextEditingController companySirenController = TextEditingController();
  TextEditingController companyTypeController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController signController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController siretController = TextEditingController();
  TextEditingController rcsController = TextEditingController();
  TextEditingController greffeController = TextEditingController();
  TextEditingController apeController = TextEditingController();
  TextEditingController vatController = TextEditingController();
  TextEditingController capitalController = TextEditingController();
  FocusNode companyTypeFocus = FocusNode();
  FocusNode companyNameFocus = FocusNode();
  FocusNode companySirenFocus = FocusNode();
  FocusNode signFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  FocusNode postCodeFocus = FocusNode();
  FocusNode cityFocus = FocusNode();
  FocusNode telephoneFocus = FocusNode();
  FocusNode siretFocus = FocusNode();
  FocusNode rcsFocus = FocusNode();
  FocusNode greffeFocus = FocusNode();
  FocusNode apeFocus = FocusNode();
  FocusNode vatFocus = FocusNode();
  FocusNode capitalFocus = FocusNode();
  @override
  void onInit() {
    appLanguge.addLocal(XLocal());
    titles = [
      'first_start_create_user'.tr,
      'first_start_company_info'.tr,
      'first_start_confirm'.tr,
    ];
    pageController = PageController(initialPage: rxCurrentPageIndex.value);
    super.onInit();
  }

  getInformationBySiren() async {
    String siren = companySirenController.text;
    if (siren.trim() != '') {
      var json = await Terminal.currentTerminal!.getCompanyBySiren(siren);
      companyNameController.text = json['company'] ?? '';
      setCompanyValue('name', json['company'] ?? '');
      signController.text = json['sign'] ?? json['company'] ?? '';
      if (json['sign'] != null && json['sign'] != null) {
        setCompanyValue('sign', json['sign'] ?? '');
      }
      addressController.text = json['address'] ?? '';
      setCompanyValue('address', json['address'] ?? '');
      postCodeController.text = json['postCode'] ?? '';
      setCompanyValue('postCode', json['postCode'] ?? '');
      cityController.text = json['city'] ?? '';
      setCompanyValue('city', json['city'] ?? '');
      siretController.text = json['siret'] ?? '';
      setCompanyValue('siret', json['siret'] ?? '');
      apeController.text = json['apeCode'] ?? '';
      setCompanyValue('apeCode', json['apeCode'] ?? '');
      vatController.text = json['vatNumber'] ?? '';
      setCompanyValue('vatNumber', json['vatNumber'] ?? '');
      XController.requestFocus(FocusNode());
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  bool get canHaveInvoice {
    return rxCompany['canHaveInvoice'] ?? false;
  }

  set canHaveInvoice(value) {
    rxCompany['canHaveInvoice'] = value;
    rxCompany.refresh();
  }

  bool get canHaveProof {
    return rxCompany['canHaveProof'] ?? false;
  }

  set canHaveProof(value) {
    rxCompany['canHaveProof'] = value;
    rxCompany.refresh();
  }

  setRootUserValue(String key, String value) {
    rxUser[key] = value;
  }

  setCompanyValue(String key, String value) {
    rxCompany[key] = value;
  }

  changePage(int idx) {
    rxCurrentPageIndex.value = idx;
  }

  validRootUser() {
    if (userFormKey.currentState?.validate() == true) {
      if (rxCompany['name'] == null) {
        companySirenFocus.requestFocus();
      } else {
        XController.requestFocus(FocusNode());
      }
      nextPage();
    }
  }

  validCompany() {
    if (companyFormKey.currentState?.validate() == true) {
      nextPage();
      XController.requestFocus(FocusNode());
    }
  }

  prePage() {
    if (rxCurrentPageIndex.value > 0) {
      rxCurrentPageIndex.value--;
      pageController?.jumpToPage(rxCurrentPageIndex.value);
    }
  }

  nextPage() {
    if (rxCurrentPageIndex.value < 2) {
      rxCurrentPageIndex.value++;
      pageController?.jumpToPage(rxCurrentPageIndex.value);
    }
  }

  submit() async {
    rxIsSubmiting.value = true;
    var r = await Shop().startup({'user': rxUser.toJson(), 'company': rxCompany.toJson()});
    rxIsSubmiting.value = false;
    if (r == true) {
      close(true);
    }
  }
}
