import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sdk/xView.dart';
import 'package:weco_admin/home/controller.dart';

import '../departments/department/view.dart';
import '../system_menu/menu_view.dart';
import '../tool/mydrawer.dart';
import '../theme.dart';
import 'controller.dart';

class ScheduleView extends XView<ScheduleController> {
  ScheduleView(args, ScheduleController controller) : super(args, controller);

  @override
  Widget build(BuildContext context) {
    // double defaultPadding = 20.0;

    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: SideMenu()),
          Expanded(
              flex: 5,
              child: Column(
                children: [
                  _buildSearchFile(context),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  _bulidScheduleDrawer(context),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        spacing: defaultPadding * 8, // 设置日期部件之间的间隔
                        children: List.generate(
                          7,
                          (index) => Obx(
                            () => Text(formatDate(ctl.weekDates[index].value)),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: ctl.nextPage,
                        child: Text('Next Week'),
                      ),
                    ],
                  )
                ],
              )),
        ],
      )),
    );
  }

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}';
  }

  Column _bulidScheduleDrawer(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: defaultPadding, right: defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildChangeTime(context),
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

  ElevatedButton _buildChangeTime(BuildContext context) {
    // final ScheduleController _dropdownController =
    //     Get.put(ScheduleController());

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
              horizontal: defaultPadding / 2, vertical: defaultPadding),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('Month'), // 放置文本组件
          SizedBox(width: 8), // 为了在文本和图标之间添加间距，可以根据需要调整
          Icon(Icons.expand_more), // 放置图标组件
        ],
      ),
      onPressed: () {
        RDrawer.open(
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: defaultPadding),
                  child: Card(child: _buildDropdownExample()),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: _buildScheduleDays(),
                ),
                Card(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('日历详情'),
                            IconButton(
                                onPressed: () {
                                  showSelectionCard();
                                },
                                icon: Icon(Icons.add))
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.check_box,
                              color: Colors.green,
                            ),
                            Text('技术维护'),
                          ],
                        ),
                      ]),
                ),
              ],
            ),
          ),
          dir: DrawerDirEnum.right,
          width: 450,
          maskClose: true,
        );
      },
    );
  }

  void showSelectionCard() {
    showModalBottomSheet(
      backgroundColor: secondaryColor,
      context: Get.context!,
      builder: (BuildContext context) {
        return Container(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('Item $index'),
                onTap: () {
                  print('Selected Item $index');
                  // Get.back();
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildDropdownExample() {
    final ScheduleController controller = Get.find<ScheduleController>();

    return GetBuilder<ScheduleController>(
      init: controller,
      builder: (controller) {
        List<int> _yearList = List<int>.generate(DateTime.now().year - 1899,
            (i) => i + 1900); // Generate list of years

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<int>(
              value: controller.selectedYear.value,
              icon: Icon(Icons.expand_more),
              iconSize: 40,
              elevation: 16,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
              underline: Container(
                height: 2,
                color: Colors.transparent,
              ),
              onChanged: (int? newValue) {
                controller.updateSelectedYear(newValue!);
              },

              selectedItemBuilder: (BuildContext context) {
                return _yearList.map<Widget>((int year) {
                  return Center(child: Text(year.toString()));
                }).toList();
              },
              menuMaxHeight: 250, // 设置下拉菜单的最大高度
              items: _yearList.map<DropdownMenuItem<int>>((int year) {
                return DropdownMenuItem<int>(
                  value: year,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 50), // 设置项的高度
                    child: Center(child: Text(year.toString())),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  GetBuilder<ScheduleController> _buildScheduleDays() {
    return GetBuilder<ScheduleController>(
      init: ScheduleController(),
      builder: (_) {
        var daysInMonth = _.getDaysInMonth(); // 使用 _ 代替 controller
        return Card(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => _.previousMonth(),
                  ),
                  Obx(() => Text(
                        '${_.selectedYear.value}-${_.selectedMonth.toString().padLeft(2, '0')}',
                        style: TextStyle(fontSize: defaultPadding),
                      )),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () => _.nextMonth(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('日'),
                      Text('一'),
                      Text('二'),
                      Text('三'),
                      Text('四'),
                      Text('五'),
                      Text('六')
                    ]),
              ),
              GridView.count(
                crossAxisCount: 7,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ...List.generate(
                    DateTime(_.selectedYear.value, _.selectedMonth.value, 1)
                            .weekday %
                        7,
                    (index) => SizedBox(),
                  ),
                  ...daysInMonth.map((day) {
                    bool isPast = day.isBefore(_.today);
                    return MouseRegion(
                      onEnter: (event) =>
                          _.hoverColor = Colors.grey.withOpacity(0.2),
                      onExit: (event) => _.hoverColor = Colors.transparent,
                      child: InkWell(
                        onTap: () => _.selectDate(day),
                        hoverColor: isPast ? Colors.transparent : _.hoverColor,
                        child: Container(
                          color: _.defaultColor,
                          child: Center(
                            child: Text(
                              day.day.toString(),
                              style: TextStyle(
                                color: isPast ? Colors.grey : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ],
          ),
        );
      },
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
                "时间表计划",
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
}
