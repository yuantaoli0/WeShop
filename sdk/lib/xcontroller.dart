import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'util/text_teditor.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:vibration/vibration.dart';
import 'util/format.dart';

class XScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.invertedStylus,
        PointerDeviceKind.unknown,
        // etc.
      };
}

abstract class XController extends GetxController {
  List<FocusNode>? focusNodes;
  dynamic result;
  static requestFocus(FocusNode focusNode) {
    FocusScope.of(Get.context!).requestFocus(focusNode);
  }

  hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  onReady() {
    requestFullScreen();
    super.onReady();
  }

  static bool get isTablet {
    //return Get.context?.isTablet ?? true;
    MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    return data.size.shortestSide >= 550;
  }

  bool get isPhone {
    /*MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    return data.size.shortestSide < 550;*/
    return min(Get.height, Get.width) < 550;
  }

  static requestFullScreen() {
    if (Platform.isAndroid) {
      //SystemChrome.setEnabledSystemUIOverlays([]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    }
  }

  bool get isUnderModal {
    return Get.isBottomSheetOpen == true || Get.isDialogOpen == true;
  }

  nextFocus({FocusNode? node, int currentIndex = 0}) {
    if (focusNodes != null) {
      if (node != null) {
        var idx = focusNodes!.indexOf(node);
        if (idx >= 0) {
          idx++;
          if (focusNodes!.length > idx) {
            requestFocus(focusNodes![idx]);
          }
        }
      } else if (currentIndex >= 0 && currentIndex + 1 < focusNodes!.length) {
        requestFocus(focusNodes![currentIndex + 1]);
      }
    }
  }

  nextFocusIndex(int idx) {
    if (focusNodes != null) {
      if (idx >= 0 && focusNodes!.length > idx) {
        if (focusNodes!.length > idx) {
          requestFocus(focusNodes![idx]);
        }
      }
    }
  }

  close([result]) {
    this.result = result;
    Get.back(result: result);
  }

  void accept() {
    close(true);
  }

  void refuse() {
    close(false);
  }

  static Future<DateTimeRange?> getDateRange({DateTimeRange? dateTimeRange}) async {
    return await showDateRangePicker(
      context: Get.context!,
      initialDateRange: dateTimeRange,
      currentDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    );
  }

  static getCode({String? title, String hint = ""}) async {
    TextEditingController editor = TextEditingController();
    var r = await Get.dialog(
      AlertDialog(
          title: Text(title!),
          content: Material(
            child: TextField(
              controller: editor,
              autofocus: true,
              obscureText: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                hintText: hint,
                hintStyle: TextStyle(fontSize: ScreenUtil().setSp(14)),
              ),
              onSubmitted: (v) {
                Get.back(result: v);
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text('dialog_yes'.tr),
              onPressed: () {
                Get.back(result: editor.text);
              },
            ),
            TextButton(
              child: Text('dialog_no'.tr),
              onPressed: () {
                Get.back(result: '');
              },
            ),
          ]),
    );
    requestFullScreen();
    return r;
  }

  static getString({String? title, String hint = "", String defaultValue = "", int lines = 1}) async {
    TextEditingController editor = TextEditingController(text: defaultValue);
    if (defaultValue != "") {
      editor.selectAll();
    }
    var r = await Get.dialog(
      AlertDialog(
          title: Text(title!),
          content: Material(
            child: TextField(
              controller: editor,
              autofocus: true,
              maxLines: lines,
              minLines: lines,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                hintText: hint,
                hintStyle: TextStyle(fontSize: ScreenUtil().setSp(14)),
              ),
              onSubmitted: (v) {
                Get.back(result: v);
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text('dialog_yes'.tr),
              onPressed: () {
                Get.back(result: editor.text);
              },
            ),
            TextButton(
              child: Text('dialog_no'.tr),
              onPressed: () {
                Get.back(result: null);
              },
            ),
          ]),
    );
    requestFullScreen();
    return r;
  }

  static getNumber({String title = '', double? defaultValue = 0}) async {
    TextEditingController editor = TextEditingController(text: defaultValue == null ? '' : format.number(defaultValue));
    editor.selection = TextSelection(
      baseOffset: 0,
      extentOffset: editor.text.length,
    );
    var r = await Get.dialog(
      CupertinoAlertDialog(
          title: Text(title),
          content: Material(
            child: TextField(
              controller: editor,
              autocorrect: false,
              enableSuggestions: false,
              onEditingComplete: () {
                try {
                  var v = format.parse(editor.text);
                  Get.back(result: v);
                } catch (ex) {
                  Get.back();
                }
              },
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              autofocus: true,
            ),
          ),
          actions: [
            TextButton(
              child: Text('dialog_yes'.tr),
              onPressed: () {
                try {
                  var v = format.parse(editor.text);
                  Get.back(result: v);
                } catch (ex) {
                  Get.back();
                }
              },
            ),
            TextButton(
              child: Text('dialog_no'.tr),
              onPressed: () {
                Get.back();
              },
            ),
          ]),
    );
    requestFullScreen();
    return r;
  }

  static getConfirm({String? title, String? content}) async {
    return await Get.dialog(
      CupertinoAlertDialog(
        title: Text(title!),
        content: Text(content ?? ''),
        actions: [
          TextButton(
            child: Text('dialog_yes'.tr),
            onPressed: () {
              Get.back(result: true);
            },
          ),
          TextButton(
            child: Text('dialog_no'.tr),
            onPressed: () {
              Get.back(result: false);
            },
          ),
        ],
      ),
    );
  }

  static getColor(Color? color) async {
    Color pickerColor = color ?? Colors.blue;
// raise the [showDialog] widget
    return await Get.dialog(
      AlertDialog(
        title: Text('dialog_pick_color'.tr),
        content: SingleChildScrollView(
          child: MaterialPicker(
            pickerColor: pickerColor,
            onColorChanged: (color) {
              pickerColor = color;
            },
            enableLabel: true,
          ),
          // Use Material color picker:
          //
          // child: MaterialPicker(
          //   pickerColor: pickerColor,
          //   onColorChanged: changeColor,
          //   showLabel: true, // only on portrait mode
          // ),
          //
          // Use Block color picker:
          //
          // child: BlockPicker(
          //   pickerColor: currentColor,
          //   onColorChanged: changeColor,
          // ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('dialog_yes'.tr),
            onPressed: () {
              Get.back(result: pickerColor);
              //Navigator.of(context).pop(pickerColor);
            },
          ),
          TextButton(
            child: Text('dialog_no'.tr),
            onPressed: () {
              Get.back(result: null);
              //Navigator.of(context).pop(null);
            },
          ),
        ],
      ),
    );
  }

  static FlutterTts? flutterTts;
  static voice() {
    if (flutterTts == null) {
      flutterTts = FlutterTts();
      flutterTts?.setLanguage('fr-FR');
    }
    return flutterTts;
  }

  static showMessage(
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 2),
    TextButton? mainButton,
    bool isDialog = false,
    bool vibrate = false,
    bool requireConfirm = false,
    bool voice = false,
  }) async {
    if (vibrate == true) {
      Vibration.hasVibrator().then((value) {
        if (value == true) {
          Vibration.vibrate();
        }
      });
      //Vibration.vibrate(amplitude: 128);
    }
    if (voice == true) {
      XController.voice().speak(message);
    }
    if (isDialog == true) {
      Timer? timer;
      if (requireConfirm == false) {
        timer = Timer(duration, () {
          if (Get.isDialogOpen == true) {
            Get.back();
          }
        });
      }
      FocusNode keyboard = FocusNode();
      await Get.dialog(
        requireConfirm == false
            ? RawKeyboardListener(
                focusNode: keyboard,
                autofocus: true,
                onKey: (key) {
                  if (Get.isDialogOpen == true) {
                    Get.back();
                  }
                },
                child: AlertDialog(
                  content: Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : AlertDialog(
                contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Divider(
                      height: 2,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('Confirmation'),
                    ),
                  ],
                ),
              ),
      ).then((value) {
        if (timer != null) {
          timer.cancel();
        }
      });
      keyboard.requestFocus();
    } else {
      Get.snackbar(
        '',

        ///title??'',
        message,
        titleText: title != null ? Text(title) : Container(),
        duration: duration,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.GROUNDED,
        backgroundColor: Colors.black,
        colorText: Colors.white,
        borderRadius: 0,
        margin: EdgeInsets.zero,
        mainButton: mainButton ??
            TextButton(
              child: Text('dialog_OK'.tr),
              onPressed: () {
                if (Get.isSnackbarOpen == true) {
                  Get.back();
                }
              },
            ),
        onTap: (object) {
          Get.back();
        },
      );
    }
  }
}
