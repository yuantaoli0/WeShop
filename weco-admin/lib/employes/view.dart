import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sdk/xView.dart';
import 'package:weco_admin/home/controller.dart';
import 'employescontroller.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

import '../departments/department/view.dart';
import '../system_menu/menu_view.dart';
import '../theme.dart';

class EmployeView extends XView<EmployesController> {
  EmployeView(args, EmployesController controller) : super(args, controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: SideMenu()),
          Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildSearchFile(context),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    _bulidAddJob(controller),
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                    Container(
                      padding: EdgeInsets.all(defaultPadding),
                      decoration: const BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: _buildAllContractInfo(),
                    ),
                  ],
                ),
              )),
        ],
      )),
    );
  }

  Column _buildAllContractInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey[200],
            ),
            height: 760,
            width: 1350,
            padding: EdgeInsets.all(10.0),
            child: obx(
              () => SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text("姓名"),
                    ),
                    DataColumn(
                      label: Text("生日"),
                    ),
                    DataColumn(
                      label: Text("入职时间"),
                    ),
                    DataColumn(
                      label: Text("上传合同"),
                    ),
                    DataColumn(
                      label: Text("查看"),
                    ),
                    DataColumn(
                      label: Text(" "),
                    ),
                  ],
                  rows: List.generate(ctl.rxEmployes.length,
                      (index) => ContractInfoRow(ctl.rxEmployes[index])),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  DataRow ContractInfoRow(ep) {
    List<String> parts = ep['startAt'].toString().split('T');
    String dateBeforeT = parts[0];

    List<String> birthdayparts = ep['birthday'].toString().split('T');
    String BirthdayBefore = birthdayparts[0];
    return DataRow(cells: [
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: defaultPadding),
              child: InkWell(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'jpeg', 'png'],
                  );
                  if (result != null) {
                    File file = File(result.files.single.path!);
                    ctl.updateImage(ep['_id'].toString(), file, ep);
                  } else {
                    print('User canceled the picker');
                  }
                },
                child: ClipOval(
                  child: Obx(
                    () {
                      return Image(
                        image: ctl.selectedImages[ep['_id'].toString()] != null
                            ? FileImage(
                                    ctl.selectedImages[ep['_id'].toString()]!)
                                as ImageProvider<Object>
                            : AssetImage('assets/images/useravatar.png')
                                as ImageProvider<Object>,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ep['name'].toString()),
                Text(
                  ep['sex'].toString(),
                  style: TextStyle(
                      color: Color(0xFF707276), fontSize: defaultPadding / 1.8),
                ),
              ],
            ),
          ],
        ),
      ),
      DataCell(Text(BirthdayBefore)),
      DataCell(Text(dateBeforeT)),
      DataCell(IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.upload_file,
            size: defaultPadding * 1.5,
          ))),
      DataCell(
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.plagiarism,
            size: defaultPadding * 1.5,
          ),
        ),
      ),
      DataCell(
        IconButton(
          onPressed: () {
            ctl.delEmploye(ep);
          },
          icon: Icon(
            Icons.delete_forever,
            size: defaultPadding * 1.5,
          ),
        ),
      ),
    ]);
  }

  Container _buildSearchFile(BuildContext context) {
    return Container(
        color: Color(0xFF252525),
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            children: [
              Text(
                "合同管理",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
              Spacer(
                flex: 2,
              ),
              //搜索条
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.white)),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      hintText: "Search",
                      // ignore: prefer_const_constructors
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      // fillColor: Color.fromARGB(153, 184, 184, 219),
                      filled: true,
                      // ignore: prefer_const_constructors
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      suffixIcon: InkWell(
                        onTap: () {},
                        child: Container(
                          // ignore: prefer_const_constructors
                          padding: EdgeInsets.all(defaultPadding * 0.25),
                          margin: EdgeInsets.symmetric(
                              horizontal: defaultPadding / 10),
                          // ignore: prefer_const_constructors
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/search.svg",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //用户头像
              Container(
                margin: EdgeInsets.only(left: defaultPadding),
                // ignore: prefer_const_constructors
                padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding / 2),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black12)),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/user.png",
                      height: 38,
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: defaultPadding / 10),
                      child: Text("Yuantao Li"),
                    ),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Column _bulidAddJob(EmployesController controller) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: defaultPadding, right: defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ignore: prefer_const_constructors
              Text(
                "公司所有员工合同",
                style: const TextStyle(color: Color(0xFF5F5E61), fontSize: 20),
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    _showCustomDialog(controller);
                    // ctl.newEmploye("dsa");
                  },
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding * 1.5,
                          vertical: defaultPadding)),
                  icon: const Icon(Icons.add),
                  label: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: defaultPadding / 5),
                    child: Text("Add New"),
                  )),
              // ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: defaultPadding),
          child: Container(
            height: 2.0,
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(112, 114, 118, 0.250),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }
}

void _showCustomDialog(EmployesController controller) {
  controller.textControllers.forEach((controller) => controller.clear());
  Get.dialog(
    Dialog(
      child: Container(
        width: 300,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(
              4,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextFormField(
                  controller: controller.textControllers[index],
                  decoration: InputDecoration(
                    labelText: controller.labelText[index],
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    '取消',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                  onPressed: () {
                    List<String> inputData = controller.textControllers
                        .map((controller) => controller.text)
                        .toList();

                    controller.newEmploye(inputData);
                    Get.back();
                  },
                  child: Text('确认', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
