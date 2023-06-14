import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionController extends GetxController {
  RxInt selectedIndex = RxInt(-1);
  RxBool isImageLoaded = false.obs;
   Timer? _timer;

  @override
  void onInit() {
    super.onInit();
  }

  final List<Function()> buttonActions = [
    () async {
      Get.toNamed('/work');
    },
    () {
      print('Button 2 pressed');
    },
    () {
      print('Button 3 pressed');
    },
    () {
      print('Button 4 pressed');
    },
    () {
      print('Button 5 pressed');
    },
    () {
      print('Button 6 pressed');
    },
    () {
      print('Button 7 pressed');
    },
    () {
      print('Button 8 pressed');
    },
  ];

  void confirmAction() {
    if (selectedIndex.value >= 0 &&
        selectedIndex.value < buttonActions.length) {
      buttonActions[selectedIndex.value]();
    } else {
      print('Please select a button first.');
    }
  }

  void cancel() {
    Get.offAllNamed('/home');
  }

  // 定义按钮的图标列表
  final List<IconData> buttonIcons = [
    Icons.brightness_high,
    Icons.transfer_within_a_station,
    Icons.brightness_4,
    Icons.alarm_add,
    Icons.arrow_upward,
    Icons.arrow_downward,
    Icons.arrow_forward,
    Icons.arrow_back,
  ];

  // 定义按钮的文本列表
  final List<String> buttonTexts = [
    'go_work',
    'off_work',
    'going_out',
    'overtime',
    '按钮 5',
    '按钮 6',
    '按钮 7',
    '按钮 8',
  ];
  RxInt currentPageIndex = 0.obs; //圆形下标
}

extension ChunkedExtension<E> on List<E> {
  List<List<E>> chunked(int size) {
    return List.generate((length / size).ceil(), (index) {
      int start = index * size;
      int end = start + size;
      return sublist(start, end > length ? length : end);
    });
  }
}
