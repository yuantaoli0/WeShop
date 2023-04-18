import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/xcontroller.dart';

class ScheduleController extends GetxController {
  late RxInt selectedMonth;
  late RxInt selectedYear;
  Color hoverColor = Colors.grey.withOpacity(0.2);
  Color defaultColor = Colors.transparent;
  DateTime today = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    selectedMonth = DateTime.now().month.obs;
    selectedYear = DateTime.now().year.obs;
  }


  void updateSelectedYear(int newYear) {
    selectedYear.value = newYear;
    update();
  }

  void previousMonth() {
    if (selectedMonth.value == 1) {
      selectedMonth.value = 12;
      selectedYear.value--;
    } else {
      selectedMonth.value--;
    }
    update(); // 添加此行以更新UI
  }

  void nextMonth() {
    if (selectedMonth.value == 12) {
      selectedMonth.value = 1;
      selectedYear.value++;
    } else {
      selectedMonth.value++;
    }
    update();
  }

  List<DateTime> getDaysInMonth() {
    var firstDay = DateTime(selectedYear.value, selectedMonth.value, 1);
    var lastDay = DateTime(selectedYear.value, selectedMonth.value + 1, 0);
    var days = lastDay.difference(firstDay).inDays + 1;
    return List.generate(days, (i) => firstDay.add(Duration(days: i)));
  }

  void selectDate(DateTime day) {
    if (!day.isBefore(today)) {
      print('Selected date: ${day.toString()}');
    }
  }
}
