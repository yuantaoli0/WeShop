import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sdk/language.dart';
import 'package:sdk/util/xlogger.dart';
import 'package:sdk/xcontroller.dart';

import 'package:get/get.dart';
import 'package:weco_admin/tool/theme.dart';
import 'router.dart';


Future<void> main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    bool inDebug = false;
    assert(() {
      inDebug = true;
      return true;
    }());
    // In debug mode, use the normal error widget which shows
    // the error message:
    if (inDebug) return ErrorWidget(details.exception);
    // In release builds, show a yellow-on-blue message instead:
    return Container(
      alignment: Alignment.center,
      child: Text(
        details.exception.toString(),
        style: const TextStyle(color: Colors.yellow),
        textDirection: TextDirection.ltr,
      ),
    );
  };

  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized(); //<= the key is here

    FlutterError.onError = (FlutterErrorDetails errorDetails) {
      log(errorDetails.exception.toString());
      log(errorDetails.stack.toString());
      XLogger().e(errorDetails.exception.toString());
      XLogger().e(errorDetails.stack.toString());
      //logger.d(errorDetails.exception.toString());
      //Logger(printer: SimplePrinter(colors: true)).v('boom');
      //Utilities.log("Will log here ${errorDetails.exception.toString()}");
    };
    //WidgetsFlutterBinding.ensureInitialized();
    runApp(MyHomePage());
  }, (error, stackTrace) {
    XLogger().e(error.toString());

    XLogger().e(stackTrace.toString());
    //Logger(printer: SimplePrinter(colors: true)).v('boom');
    //Utilities.log("Others catching ${error.toString()}");
  });
}

class MyHomePage extends StatelessWidget {
  bool get isPhone {
    var sSize = window.physicalSize;
    //XLogger().e('size:' + math.min(Get.height, Get.width).toString());
    if (math.min(sSize.height, sSize.width) == 0) {
      return false;
    }

    return math.min(sSize.height, sSize.width) < 550;
    /*MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    XLogger().e('windows size:' + data.size.shortestSide.toString());
    if (data.size.shortestSide == 0) {
      return false;
    }
    return data.size.shortestSide < 550;*/
  }

  @override
  Widget build(BuildContext context) {
    //if (Platform.isAndroid) {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    // }
    //GestureBinding.instance.resamplingEnabled = true;
    //log('width:' + Get.width.toString());
    var physicalScreenSize = window.physicalSize;
    var physicalWidth = physicalScreenSize.width;
    var physicalHeight = physicalScreenSize.height;
    return MediaQuery(
      data: MediaQueryData(
          size: Size(
              physicalWidth == 0 ? (isPhone ? 360 : 3840) : physicalWidth,
              physicalHeight == 0
                  ? (isPhone ? 672 : 2160)
                  : physicalHeight)), // MediaQueryData.fromWindow(WidgetsBinding.instance!.window),
      child: ScreenUtilInit(
        designSize: isPhone ? const Size(360, 672) : const Size(966.04, 603.77),
        //splitScreenMode: true,
        //minTextAdapt: true,
        builder: (ctx, widget) => GetMaterialApp(
          title: 'Weco Admin',
          theme: appTheme,
          locale: Get.deviceLocale,
          scrollBehavior: XScrollBehavior(),
          debugShowCheckedModeBanner: false,
          translations: appLanguge,
          fallbackLocale: const Locale('fr', 'FR'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLanguge.supportedLocales(),
          initialRoute: '/',
          onGenerateRoute: XRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
