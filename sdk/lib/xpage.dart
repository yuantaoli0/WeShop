import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class XPage extends Scaffold {
  const XPage({
    Key? key,
    PreferredSizeWidget? appBar,
    Widget? body,
    Widget? floatingActionButton,
    FloatingActionButtonLocation? floatingActionButtonLocation,
    FloatingActionButtonAnimator? floatingActionButtonAnimator,
    List<Widget>? persistentFooterButtons,
    Widget? drawer,
    DrawerCallback? onDrawerChanged,
    Widget? endDrawer,
    Widget? bottomNavigationBar,
    Widget? bottomSheet,
    Color? backgroundColor,
    bool? resizeToAvoidBottomPadding,
    bool? resizeToAvoidBottomInset,
    bool primary = true,
    DragStartBehavior drawerDragStartBehavior = DragStartBehavior.start,
    bool extendBody = false,
    bool extendBodyBehindAppBar = false,
    Color? drawerScrimColor,
    double? drawerEdgeDragWidth,
    bool drawerEnableOpenDragGesture = true,
    bool endDrawerEnableOpenDragGesture = true,
  }) : super(
          key: key,
          appBar: appBar,
          body: body,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          floatingActionButtonAnimator: floatingActionButtonAnimator,
          persistentFooterButtons: persistentFooterButtons,
          drawer: drawer,
          onDrawerChanged: onDrawerChanged,
          /* ??
              (isOpen) {
                if (isOpen) {
                  if (Platform.isAndroid) {
                    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
                  }
                } else {
                  if (Platform.isAndroid) {
                    SystemChrome.setEnabledSystemUIOverlays([]);
                  }
                }
              },*/
          endDrawer: endDrawer,
          bottomNavigationBar: bottomNavigationBar,
          bottomSheet: bottomSheet,
          backgroundColor: backgroundColor,
          //resizeToAvoidBottomPadding: resizeToAvoidBottomPadding,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          primary: primary,
          drawerDragStartBehavior: drawerDragStartBehavior,
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          drawerScrimColor: drawerScrimColor,
          drawerEdgeDragWidth: drawerEdgeDragWidth,
          drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
          endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
        );
}

class XAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onTap;
  final Widget? appBar;
  static bool hasTaskbar = false;
  const XAppBar({Key? key, this.onTap, this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap ??
            () {
              if (Platform.isAndroid) {
                if (!hasTaskbar) {
                  //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

                  hasTaskbar = true;
                } else {
                  //SystemChrome.setEnabledSystemUIOverlays([]);
                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
                  hasTaskbar = false;
                }
              }
            },
        child: appBar);
  }

  // TODO: implement preferredSize
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
