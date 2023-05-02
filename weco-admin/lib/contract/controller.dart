import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sdk/models/shop.dart';
import 'package:sdk/xcontroller.dart';
import 'package:sdk/models/contract.dart';

class ContractController extends XController {
  RxList<Contract> rxContract = RxList([]);
  RxBool rxIsloading = false.obs;

  List<String> labelText = [
    '合同类型',
    '创建时间',
  ];
  List<TextEditingController> textControllers =
      List.generate(4, (index) => TextEditingController());

  loadContract() {
    rxIsloading.value = true;
    rxContract.clear();
    Shop().loadContracts().then((contracts) {
      rxContract.addAll(contracts);
      rxIsloading.value = false;
    }).catchError((e) {
      rxIsloading.value = false;
    });
  }

  @override
  void onInit() {
    Shop().loadContracts().then((list) {
      rxContract.addAll(list);
    });
    super.onInit();
  }

  newContract(List<String> inputData) async {
    Contract cs = Contract({
      'name': inputData[0],
      'createdAt': inputData[1],
    });
    // if (await ep.save() == true) {
    //   loadEmployes();
    // }
    if (await cs.save() == true) {
      loadContract();
      // 设置新添加的员工的默认头像
      // selectedImages[ep['_id'].toString()] = null;
    }
  }

  delContract(Contract cs) async {
    if (await XController.getConfirm(
            title: 'Confirmation', content: 'Vous etes sur?') ==
        true) {
      await cs.del();
      rxContract.remove(cs);
      close(false);
    }
  }

  // RxMap<String, File?> selectedImages = RxMap<String, File?>();
}
