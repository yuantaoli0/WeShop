import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sdk/models/department.dart';
import 'package:sdk/xView.dart';

import '../department/controller.dart';
import '../system_menu/menu_view.dart';
import '../theme.dart';

class DepartmentView extends XView<DepartmentController> {
  DepartmentView(args, DepartmentController controller)
      : super(args, controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: SideMenu()),
          Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Column(children: [
                  _buildSearchFile(context),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  _bulidAddJob(),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  Container(
                    height: 760,
                    width: 1350,
                    color: bgColor,
                    child: obx(
                      () => GridView.builder(
                        shrinkWrap: true,
                        itemCount: ctl.rxDepartments.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                crossAxisSpacing: defaultPadding * 4,
                                mainAxisSpacing: defaultPadding),
                        itemBuilder: (context, index) => _buildFileInfoCard(
                            departement: ctl.rxDepartments[index],
                            controller: controller),
                      ),
                    ),
                  ),
                ]),
              )),
        ],
      )),
    );
  }

  _buildSearchFile(BuildContext context) {
    return Container(
        color: Color(0xFF252525),
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            children: [
              Text(
                "部门管理",
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

  Column _bulidAddJob() {
    TextEditingController nameController = TextEditingController();
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
                "公司所有部门岗位",
                style: const TextStyle(color: Color(0xFF5F5E61), fontSize: 20),
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    Get.defaultDialog(
                        barrierDismissible: false,
                        title: '添加岗位信息',
                        titleStyle: TextStyle(color: Colors.black),
                        content: Column(
                          children: [
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: '输入岗位',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                        cancel: ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("取消",
                                style: TextStyle(color: Colors.black))),
                        confirm: ElevatedButton(
                          onPressed: () {
                            ctl.newJob(nameController.text);
                            Get.back();
                          },
                          child:
                              Text("确认", style: TextStyle(color: Colors.black)),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                        ));
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

_buildFileInfoCard({departement, controller}) {
  List<String> parts = departement['createdAt'].toString().split('T');
  String dateBeforeT = parts[0];

  return Container(
    padding: const EdgeInsets.all(defaultPadding),
    // ignore: prefer_const_constructors
    decoration: BoxDecoration(
        color: Color(0xFFB9B9B9),
        borderRadius: const BorderRadius.all(Radius.circular(defaultPadding))),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(defaultPadding * 0.3),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Color(0xFF4F96F7),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: SvgPicture.asset(
                  (departement['svgSrc'] ?? 'assets/icons/job_analysts.svg')
                      .toString(),
                  color: Colors.white,
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert),
                color:
                    Colors.white, // Set the background color of the popup menu
                elevation: 16,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      15.0), // Set the corner radius of the popup menu
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'Modifi',
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: controller.nameController,
                            focusNode: controller.nameNode,
                            textInputAction: TextInputAction.done,
                            // validator: Validator().notEmpty,
                            decoration: InputDecoration(
                              hintText: '修改部门名'.tr,
                            ),
                            onFieldSubmitted: (String value) {
                              controller.setDepartmentValue(
                                  'name', value, departement);
                              print('Entered value: $value');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Delete',
                    child: Text('   删除部门'),
                  ),
                ],
                onSelected: (String value) {
                  // Handle the selected option here
                  if (value == 'Delete') {
                    controller.delDepartment(departement);
                  }
                },
              )
            ],
          ),
          Container(
            height: 2.0,
            margin:
                const EdgeInsets.symmetric(horizontal: defaultPadding * 0.1),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(112, 114, 118, 0.250),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "部门所在",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: defaultPadding * 1.2,
                    fontWeight: FontWeight.w900),
              ),
              Row(
                children: [
                  Icon(
                    Icons.group,
                    color: Colors.white70,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: defaultPadding),
                    child: Text(
                      departement['name'].toString(),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.watch_later,
                    color: Colors.white70,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: defaultPadding),
                    child: Text(dateBeforeT),
                  ),
                ],
              ),
            ],
          ),
        ]),
  );
}
