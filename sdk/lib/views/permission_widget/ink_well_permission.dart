import 'package:flutter/material.dart';
import 'package:sdk/models/user.dart';
import 'package:sdk/persmission.dart';
import 'package:sdk/views/request_permission/router.dart';

class InkWellPermission extends InkResponse {
  XPermission? permission;
  @override
  Widget? child;
  @override
  GestureTapCallback? onTap;
  InkWellPermission({
    Key? key,
    this.child,
    @required this.permission,
    this.onTap,
    GestureTapCallback? onDoubleTap,
    GestureLongPressCallback? onLongPress,
    GestureTapDownCallback? onTapDown,
    GestureTapCancelCallback? onTapCancel,
    ValueChanged<bool>? onHighlightChanged,
    ValueChanged<bool>? onHover,
    MouseCursor? mouseCursor,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    MaterialStateProperty<Color>? overlayColor,
    Color? splashColor,
    InteractiveInkFeatureFactory? splashFactory,
    double? radius,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    bool enableFeedback = true,
    bool excludeFromSemantics = false,
    FocusNode? focusNode,
    bool canRequestFocus = true,
    ValueChanged<bool>? onFocusChange,
    bool autofocus = false,
  }) : super(
          key: key,
          child: child,
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          onTapDown: onTapDown,
          onTapCancel: onTapCancel,
          onHighlightChanged: onHighlightChanged,
          onHover: onHover,
          mouseCursor: mouseCursor,
          containedInkWell: true,
          highlightShape: BoxShape.rectangle,
          focusColor: focusColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          overlayColor: overlayColor,
          splashColor: splashColor,
          splashFactory: splashFactory,
          radius: radius,
          borderRadius: borderRadius,
          customBorder: customBorder,
          enableFeedback: enableFeedback,
          excludeFromSemantics: excludeFromSemantics,
          focusNode: focusNode,
          canRequestFocus: canRequestFocus,
          onFocusChange: onFocusChange,
          autofocus: autofocus,
        ) {
    if (permission != null) {
      var old = onTap;
      if (old != null) {
        onTap = () async {
          if (User.currentUser?.canAccess(permission!.url) == false) {
            var r = await RequestPermissionRouter().gotoName('/requestPermission', args: {'permission': permission});
            if (r == true) {
              old();
            }
          } else {
            old();
          }
        };
        if (permission?.isPermission == false || User.currentUser?.hasPermission(permission!.url) == false) {
          child = const SizedBox.shrink();
        }
      } else {
        child = Container(
          color: Colors.grey.withOpacity(0.8),
          child: child,
        );
      }
    } else {
      child = Container();
    }
  }
}
