import 'package:flutter/material.dart';
import 'package:sdk/models/user.dart';
import 'package:sdk/persmission.dart';
import 'package:sdk/views/request_permission/router.dart';

class ElevatedButtonPermission extends ElevatedButton {
  final XPermission? permission;
  ElevatedButtonPermission({
    Key? key,
    @required this.permission,
    @required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    @required Widget? child,
  }) : super(
          key: key,
          onPressed: (User.currentUser?.canAccess(permission!.url) == false)
              ? (() async {
                  var r = await RequestPermissionRouter().gotoName('/requestPermission', args: {'permission': permission});
                  if (r == true) {
                    onPressed!();
                  }
                })
              : (() {
                  onPressed!();
                }),
          onLongPress: onLongPress,
          style: style,
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          child: permission?.isPermission == false || User.currentUser?.hasPermission(permission!.url) == false ? SizedBox.shrink() : child,
        );
}
